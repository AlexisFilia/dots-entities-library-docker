# e1 = Entity.create!(name: 'entity1', labels: 'test', descriptions: 'test')
# e2 = Entity.create!(name: 'entity2', labels: 'test', descriptions: 'test', parent: e1)
# e3 = Entity.create!(name: 'entity3', labels: 'test', descriptions: 'test', parent: e2)

# f1 = Field.create!(name: 'field1', labels: 'test', descriptions: 'test')
# f2 = Field.create!(name: 'field2', labels: 'test', descriptions: 'test')
# f3 = Field.create!(name: 'field3', labels: 'test', descriptions: 'test')
# f4 = Field.create!(name: 'field4', labels: 'test', descriptions: 'test')
# f5 = Field.create!(name: 'field5', labels: 'test', descriptions: 'test')
# f6 = Field.create!(name: 'field6', labels: 'test', descriptions: 'test')

# e1.fields << f1
# e1.fields << f2
# e2.fields << f3
# e2.fields << f4
# e3.fields << f5
# e3.fields << f6

# en1 = Enum.create!(name: 'enum1', labels: 'test', descriptions: 'test')
# en2 = Enum.create!(name: 'enum2', labels: 'test', descriptions: 'test')

# EnumerationMember.create!(name: 'enum_m1', labels: 'test', descriptions: 'test', enum: en1)
# EnumerationMember.create!(name: 'enum_m2', labels: 'test', descriptions: 'test', enum: en1)
# EnumerationMember.create!(name: 'enum_m3', labels: 'test', descriptions: 'test', enum: en1)
# EnumerationMember.create!(name: 'enum_m4', labels: 'test', descriptions: 'test', enum: en2)
# EnumerationMember.create!(name: 'enum_m5', labels: 'test', descriptions: 'test', enum: en2)
# EnumerationMember.create!(name: 'enum_m6', labels: 'test', descriptions: 'test', enum: en2)

# dt1 = Datatype.create!(name: 'datatype1', labels: 'test', descriptions: 'test')
# dt2 = Datatype.create!(name: 'datatype2', labels: 'test', descriptions: 'test')
# dt3 = Datatype.create!(name: 'datatype3', labels: 'test', descriptions: 'test')

# FieldOption.create!(field: f1, option: en1)
# FieldOption.create!(field: f2, option: dt1)
# FieldOption.create!(field: f3, option: en2)
# FieldOption.create!(field: f4, option: dt2)
# FieldOption.create!(field: f5, option: dt3)
# FieldOption.create!(field: f6, option: en1)

# a1 = Action.create!(name: 'Action1')
# a2 = Action.create!(name: 'Action2')
# a3 = Action.create!(name: 'Action3')
# a4 = Action.create!(name: 'Action4')

# AgentLink.create!(entity: e1, action: a1)
# TargetLink.create!(entity: e2, action: a1)

# AgentLink.create!(entity: e1, action: a3)
# TargetLink.create!(entity: e3, action: a3)

# AgentLink.create!(entity: e2, action: a2)
# TargetLink.create!(entity: e3, action: a2)

# AgentLink.create!(entity: e3, action: a4)
# TargetLink.create!(entity: e2, action: a4)

# AgentLink.create!(entity: e2, action: a4)
# TargetLink.create!(entity: e3, action: a4)

# AgentLink.create!(entity: e1, action: a4)
# TargetLink.create!(entity: e3, action: a4)

require 'json'
require 'fileutils'
require 'open-uri'

VERBOSE = true
VERBOSE_DETAILS = false
FEED_DB = true
FILE_CREATION = false
WITHOUT_SUPERSEDED_BY = false
ALL_FOLDERS = ['entities', 'enums', 'enums/enumeration_members', 'properties', 'properties/actions',
               'properties/fields', 'properties/specials']
ALL_VARIABLES = %w[DATATYPES_DATA MORE_SPECIFIC_DATATYPES_DATA ENUMS_DATA ENTITIES_DATA ENUM_MEMBERS_DATA
                   FIELDS_DATA ACTIONS_DATA SPECIALS_DATA]

DATATYPES = []
MORE_SPECIFIC_DATATYPES = []
ENUMS = []
ENTITIES = []
ENUM_MEMBERS = []
SUPERSEDED_BY = []
ERRORS = []
NOT_FOUND1 = []
NOT_FOUND2 = []
@counter = 0

DATATYPES_DATA = {}
MORE_SPECIFIC_DATATYPES_DATA = {}
ENUMS_DATA = {}
ENTITIES_DATA = {}
ENUM_MEMBERS_DATA = {}
FIELDS_DATA = {}
ACTIONS_DATA = {}
SPECIALS_DATA = {}

def create_file(path, extension)
  dir = File.dirname(path)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  path << ".#{extension}"
  File.new(path, 'w')
end

def get_name(element)
  element['@id'].match(/schema:(.*)/)[1]
end

def fill_info_with_langage(data, element, key, field)
  object = {}
  if element[field].is_a?(String)
    object[:en] = element[field]
  elsif element[field].is_a?(Hash)
    object[element[field]['@language']] = element[field]['@value']
  elsif element[field].is_a?(Array)
    element[field].each do |langue|
      object[langue['@language']] = langue['@value']
    end
  end
  data[key.to_sym] = object.to_json
  data
end

def fill_with_name(data, element, key, value)
  data[key.to_sym] = [] if data[key.to_sym].nil?
  if element[value].is_a?(Hash)
    data[key.to_sym] << get_name(element[value])
  elsif element[value].is_a?(Array)
    element[value].each do |domain|
      data[key.to_sym] << get_name(domain)
    end
  end
  data
end

def format_basic_infos(name, element)
  data = {
    "name": name,
    "labels": {},
    "descriptions": {}
  }

  data = fill_info_with_langage(data, element, 'labels', 'rdfs:label')
  fill_info_with_langage(data, element, 'descriptions', 'rdfs:comment')
end

def fill_property_infos(data, element)
  data = fill_with_name(data, element, 'domainIncludes', 'schema:domainIncludes')
  fill_with_name(data, element, 'rangeIncludes', 'schema:rangeIncludes')
end

def get_data(variables, file_name)
  variables.each do |variable|
    return eval(variable)[file_name.to_sym] unless eval(variable)[file_name.to_sym].nil?
  end
  NOT_FOUND1 << file_name
  {}
end

def give_inheritance(folders, file_name, parent_data)
  found = false
  folders.each do |folder|
    next if eval(folder)[file_name.to_sym].nil?

    found = true

    child_data = eval(folder)[file_name.to_sym]
    child_data['fields'] = child_data['fields'].nil? ? {} : child_data['fields']
    child_data['actions'] = child_data['actions'].nil? ? {} : child_data['actions']
    child_data['actions'] = child_data['actions'].merge(parent_data['actions'])
    child_data['fields'] = child_data['fields'].merge(parent_data['fields'])
    eval(folder)[file_name.to_sym] = child_data
    break
  end
  NOT_FOUND2 << file_name unless found
end

def call_recursive_loop(data_hash)
  @counter += 1
  return if data_hash['children'].nil?

  parent_data = get_data(ALL_VARIABLES, data_hash['name'])

  parent_data['fields'] = parent_data['fields'].nil? ? {} : parent_data['fields']
  parent_data['actions'] = parent_data['actions'].nil? ? {} : parent_data['actions']

  data_hash['children'].each do |child|
    give_inheritance(ALL_VARIABLES, child['name'], parent_data)
    call_recursive_loop(child)
  end
end

def is_data_type?(element)
  element['@type'].is_a?(Array) \
  && (element['@type'] & ['rdfs:Class', 'schema:DataType']).length == 2
end

def is_specific_data_type?(element)
  (element['rdfs:subClassOf'].is_a?(Hash) && DATATYPES.include?(element['rdfs:subClassOf']['@id'])) \
  || DATATYPES.include?(element['@type']) \
  || element['@id'] == 'schema:DataType'
end

def is_enum_from_enumerable?(element)
  element['@type'] == 'rdfs:Class' \
  && element['rdfs:subClassOf'].is_a?(Hash) \
  && !element['rdfs:subClassOf']['@id'].match(/schema:(.*)Enumeration/).nil?
end

def is_enum_child_from_enumerable?(element)
  element['@type'] == 'rdfs:Class' \
  && (element['rdfs:subClassOf'].is_a?(Array) \
    && !element['rdfs:subClassOf'].map { |sub_class| sub_class['@id'] }.select { |f| ENUMS.include?(f) }.empty?) \
    || (element['rdfs:subClassOf'].is_a?(Hash) && ENUMS.include?(element['rdfs:subClassOf']['@id']))
end

def is_property?(element)
  element['@type'] == 'rdf:Property'
end

def display_summary(data)
  puts "#{DATATYPES.count} DATATYPES have been created"
  puts "#{MORE_SPECIFIC_DATATYPES.count} MORE_SPECIFIC_DATATYPES have been created"
  puts "#{ENUMS.count} ENUMS have been created"
  puts "#{ENTITIES.count} ENTITIES have been created"
  puts "#{ENUM_MEMBERS.count} ENUMERATION_MEMBERS have been created"
  puts "#{FIELDS_DATA.count + ACTIONS_DATA.count + SPECIALS_DATA.count} PROPERTIES (ACTIONS / FIELDS / SPECIALS) have been created"
  puts "==> #{FIELDS_DATA.count} FIELDS"
  puts "==> #{ACTIONS_DATA.count} ACTIONS"
  puts "==> #{SPECIALS_DATA.count} SPECIALS"
  puts '----------------------------'
  puts "TOTAL : #{DATATYPES.count + MORE_SPECIFIC_DATATYPES.count + ENUMS.count + ENTITIES.count + ENUM_MEMBERS.count + FIELDS_DATA.count + ACTIONS_DATA.count + SPECIALS_DATA.count}"
  puts '----------------------------'
  puts "Erreurs : #{ERRORS.count}"
  p ERRORS
  if WITHOUT_SUPERSEDED_BY
    puts 'Note : Without the superseded'
  else
    puts "Number of SUPERSEDED_BY inclued : #{SUPERSEDED_BY.count}"
    p SUPERSEDED_BY
  end
  puts "#{data.count} in total in the file Schema.org"
  puts "#{@counter} in total in the file Schema.org (Tree)"
  puts '----------------------------'
  puts 'Opening the tree.jsonld file from the web'
  puts "Missing elements in the first loop: #{NOT_FOUND1.count}"
  p NOT_FOUND1
  puts "Missing elements in the second loop: #{NOT_FOUND2.count}"
  p NOT_FOUND2
end

if VERBOSE
  puts 'SCRIPT STARTING'
  puts '----------------------------'
  puts 'Opening the schema.json file from web'
end

file = open(URI.parse('https://schema.org/version/latest/schemaorg-current-https.jsonld')).read
data_hash = JSON.parse(file)

if VERBOSE
  puts '----------------------------'
  puts 'GET DATATYPES'
end

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next unless is_data_type?(element)

  name = get_name(element)

  puts "creating Data_type : #{name}" if VERBOSE_DETAILS

  DATATYPES << element['@id']
  DATATYPES_DATA[name.to_sym] = format_basic_infos(name, element)
end

if VERBOSE
  puts "#{DATATYPES.count} DATATYPES have been created"
  puts '----------------------------'
  puts 'GET MORE_SPECIFIC_DATATYPES'
end

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next unless is_specific_data_type?(element)

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  puts "creating Data_type - More Specific : #{name}" if VERBOSE_DETAILS

  MORE_SPECIFIC_DATATYPES << element['@id']
  MORE_SPECIFIC_DATATYPES_DATA[name.to_sym] = format_basic_infos(name, element)
end

if VERBOSE
  puts "#{MORE_SPECIFIC_DATATYPES.count} MORE_SPECIFIC_DATATYPES have been created"
  puts '----------------------------'
  puts 'CREATE ENUMS - Round 1'
end

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next if MORE_SPECIFIC_DATATYPES.include?(element['@id'])
  next unless is_enum_from_enumerable?(element)

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  puts "creating enum: #{name}" if VERBOSE_DETAILS

  ENUMS << element['@id']
  ENUMS_DATA[name.to_sym] = format_basic_infos(name, element)
end

puts 'CREATE ENUMS - Round 2' if VERBOSE

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next if MORE_SPECIFIC_DATATYPES.include?(element['@id'])
  next if ENUMS.include?(element['@id'])
  next unless is_enum_child_from_enumerable?(element)

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  puts "creating enum: #{name}" if VERBOSE_DETAILS

  ENUMS << element['@id']
  ENUMS_DATA[name.to_sym] = format_basic_infos(name, element)
end

if VERBOSE
  puts 'ENUMS CREATED'
  puts "#{ENUMS.count} ENUMS have been created"
  puts '----------------------------'
  puts 'CREATE ENTITIES'
end

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next if MORE_SPECIFIC_DATATYPES.include?(element['@id'])
  next if ENUMS.include?(element['@id'])
  next unless element['@type'] == 'rdfs:Class'

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  puts "creating entity: #{name}" if VERBOSE_DETAILS

  ENTITIES << element['@id']
  data = format_basic_infos(name, element)
  data[:parent] = get_name(element['rdfs:subClassOf']) if element['rdfs:subClassOf'].is_a?(Hash)
  data[:parent] = get_name(element['rdfs:subClassOf'][1]) if element['rdfs:subClassOf'].is_a?(Array)
  ENTITIES_DATA[name.to_sym] = data
end

if VERBOSE
  puts 'ENTITIES CREATED'
  puts "#{ENTITIES.count} ENTITIES have been created"
  puts '----------------------------'
  puts 'CREATE ENUMERATION_MEMBERS'
end

puts 'ENUMERATION_MEMBERS CREATED' if VERBOSE

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next if MORE_SPECIFIC_DATATYPES.include?(element['@id'])
  next if ENUMS.include?(element['@id'])
  next if ENTITIES.include?(element['@id'])

  ok = true
  if element['@type'].is_a?(Array)
    element['@type'].each do |type|
      ok = false if type.match(/schema:(.*)/).nil?
      enum = type.match(/schema:(.*)/)[1]
    end
  elsif element['@type'].is_a?(String)
    next if element['@type'].match(/schema:(.*)/).nil?

    enum = element['@type'].match(/schema:(.*)/)[1]
  end
  next unless ok

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  puts "creating enum_option: #{name}" if VERBOSE_DETAILS

  ENUM_MEMBERS << element['@id']
  data = format_basic_infos(name, element)
  data[:enum] = enum
  ENUM_MEMBERS_DATA[name.to_sym] = data
end

if VERBOSE
  puts "#{ENUM_MEMBERS.count} ENUMERATION_MEMBERS have been created"
  puts '----------------------------'
  puts 'CREATE ACTIONS / FIELDS or ENUMERATION_MEMBERS'
end

data_hash['@graph'].each do |element|
  next if !element['schema:supersededBy'].nil? && WITHOUT_SUPERSEDED_BY
  next if DATATYPES.include?(element['@id'])
  next if MORE_SPECIFIC_DATATYPES.include?(element['@id'])
  next if ENUMS.include?(element['@id'])
  next if ENTITIES.include?(element['@id'])
  next if ENUM_MEMBERS.include?(element['@id'])
  next unless is_property?(element)

  name = get_name(element)

  SUPERSEDED_BY << name unless element['schema:supersededBy'].nil?

  data = format_basic_infos(name, element)
  data = fill_property_infos(data, element)

  where = ''

  data[:rangeIncludes].each do |domain|
    if ENTITIES.include?('schema:' + domain)
      where = 'action'
      break
    elsif DATATYPES.include?('schema:' + domain) || MORE_SPECIFIC_DATATYPES.include?('schema:' + domain)
      where = 'field'
    elsif ENUMS.include?('schema:' + domain)
      where = 'enum'
    else
      ERRORS << domain
      where = 'issue'
      break
    end
  end

  data[:domainIncludes].each do |domain|
    next if ENTITIES_DATA[domain.to_sym].nil?

    if !ENTITIES_DATA[domain.to_sym].nil? && ENTITIES_DATA[domain.to_sym][:fields].nil?
      ENTITIES_DATA[domain.to_sym][:fields] =
        {}
    end
    if !ENTITIES_DATA[domain.to_sym].nil? && ENTITIES_DATA[domain.to_sym][:actions].nil?
      ENTITIES_DATA[domain.to_sym][:actions] =
        {}
    end

    case where
    when 'field'
      puts "creating entity field: #{name}" if VERBOSE_DETAILS
      FIELDS_DATA[name.to_sym] = {}
      ENTITIES_DATA[domain.to_sym][:fields][name.to_sym] = {}
    when 'action'
      puts "creating entity action: #{name}" if VERBOSE_DETAILS
      ACTIONS_DATA[name.to_sym] = {}
      ENTITIES_DATA[domain.to_sym][:actions][name.to_sym] = {}
    when 'enum'
      puts "creating special properties: #{name}" if VERBOSE_DETAILS
      SPECIALS_DATA[name.to_sym] = {}
    when 'issue'
      if VERBOSE_DETAILS
        puts '---------------------'
        puts '|       ISSUE       |'
        puts '---------------------'
      end
    end
  end
end

puts 'USE TREE TO GENERATE ENTITIES FIELDS AND ACTIONS FROM INHERITANCE' if VERBOSE
file = open(URI.parse('https://schema.org/docs/tree.jsonld')).read
data_hash2 = JSON.parse(file)
call_recursive_loop(data_hash2)
puts 'ACTIONS / FIELDS CREATED FROM INHERITANCE' if VERBOSE

if FILE_CREATION
  puts 'CREATING FILES FROM DATA' if VERBOSE
  FOLDER_ORGANISATION.each do |folder|
    eval(folder[:name]).each do |key, value|
      out_file = create_file(folder[:path] + key.to_s, 'json')
      out_file.puts(value.to_json)
      out_file.close
    end
  end
  puts 'FILES HAVE BEEN CREATED FROM DATA' if VERBOSE
end
pp DATATYPES_DATA
if FEED_DB
  puts 'CREATING DB ELEMENTS FROM DATA' if VERBOSE

  puts 'Creating datatype in DB' if VERBOSE
  data = []
  DATATYPES_DATA.keys.each do |key|
    data << { name: DATATYPES_DATA[key][:name], labels: DATATYPES_DATA[key][:labels],
              descriptions: DATATYPES_DATA[key][:descriptions], created_at: DateTime.now, updated_at: DateTime.now }
  end
  Datatype.upsert_all(data, unique_by: nil)

  data = []
  MORE_SPECIFIC_DATATYPES_DATA.keys.each do |key|
    data << { name: MORE_SPECIFIC_DATATYPES_DATA[key][:name], labels: MORE_SPECIFIC_DATATYPES_DATA[key][:labels],
              descriptions: MORE_SPECIFIC_DATATYPES_DATA[key][:descriptions], created_at: DateTime.now, updated_at: DateTime.now }
  end
  Datatype.upsert_all(data, unique_by: nil)
  puts 'datatype in DB have been created' if VERBOSE

  puts 'Creating enums in DB' if VERBOSE
  data = []
  ENUMS_DATA.keys.each do |key|
    data << { name: ENUMS_DATA[key][:name], labels: ENUMS_DATA[key][:labels],
              descriptions: ENUMS_DATA[key][:descriptions], created_at: DateTime.now, updated_at: DateTime.now }
  end
  Enum.upsert_all(data, unique_by: nil)
  puts 'enums in DB have been created' if VERBOSE

  puts 'Creating enumeration_members in DB' if VERBOSE
  data = []
  ENUM_MEMBERS_DATA.keys.each do |key|
    enum = Enum.find_by(name: ENUM_MEMBERS_DATA[key][:enum])
    next if enum.blank?

    data << { name: ENUM_MEMBERS_DATA[key][:name], labels: ENUM_MEMBERS_DATA[key][:labels],
              descriptions: ENUM_MEMBERS_DATA[key][:descriptions], created_at: DateTime.now, updated_at: DateTime.now, enum_id: enum.id }
  end
  EnumerationMember.upsert_all(data, unique_by: nil)
  puts 'enumeration_members in DB have been created' if VERBOSE

  puts 'Creating entities in DB' if VERBOSE
  data = []
  ENTITIES_DATA.keys.each do |key|
    data << { name: ENTITIES_DATA[key][:name], labels: ENTITIES_DATA[key][:labels],
              descriptions: ENTITIES_DATA[key][:descriptions], created_at: DateTime.now, updated_at: DateTime.now }
  end
  Entity.upsert_all(data, unique_by: nil)
  ENTITIES_DATA.keys.each do |key|
    parent = Entity.find_by(name: ENTITIES_DATA[key][:parent])
    child = Entity.find_by(name: ENTITIES_DATA[key][:name])
    next if parent.blank? || child.blank?

    child.update!(parent: parent)
  end
  puts 'entities in DB have been created' if VERBOSE

  puts 'DB ELEMENTS HAVE BEEN CREATED FROM DATA' if VERBOSE
end

display_summary(data_hash['@graph']) if VERBOSE

puts 'SCRIPT ENDING'

# ENTITIES_DATA = {}
# FIELDS_DATA = {}
# ACTIONS_DATA = {}
# SPECIALS_DATA = {}
