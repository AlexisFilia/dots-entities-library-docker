def database_generator
  require 'open-uri'

  require_relative 'global_variables'
  require_relative 'settings'
  require_relative 'utilities/data_collectors'
  require_relative 'utilities/basic_methods'

  puts 'SCRIPT STARTING'
  puts 'Seeding independant tables'
  # data_hash = load_file_from_web('https://schema.org/version/latest/schemaorg-current-https.jsonld')
  # collect_entities(data_hash)
  # entities_answer = Entity.upsert_all(ENTITIES, returning: %w[id name], unique_by: :name)
  # collect_datatypes(data_hash)
  # datatypes_answer = Fieldtype.upsert_all(DATATYPES, returning: %w[id name type_of], unique_by: :name)
  # collect_enums(data_hash)
  # enums_answer = Fieldtype.upsert_all(ENUMS, returning: %w[id name type_of], unique_by: :name)
  # collect_fields(data_hash)
  # fileds_answer = Field.upsert_all(FIELDS, returning: %w[id name], unique_by: :name)
  # collect_actions(data_hash)
  # actions_answer = Action.upsert_all(ACTIONS, returning: %w[id name], unique_by: :name)
  # puts 'Independant tables have been seeded'
  # puts 'Seeding dependant tables'
  # collect_enum_members(data_hash)
  # enum_members_answer = EnumerationMember.upsert_all(ENUM_MEMBERS, returning: %w[id name], unique_by: :name)
  # collect_localizables(data_hash)
  # localizables_answer = Localizable.upsert_all(LOCALIZABLES, returning: %w[id name], unique_by: :index)
  # puts 'Dependant tables have been seeded'

  # puts 'Seeding dependant tables'
  # data_hash2 = load_file_from_web('https://schema.org/docs/tree.jsonld')
  # manage_inheritance(data_hash2)
  # display_summary2
  # # create_files_from_data
  # # Second send of Entities to perform inheritance
  # entities_answer = send_to_db('EntitiesInheritance', ENTITIES_DATA, 'id name sections { id name }', entities_answer)
  # fields_answer = send_to_db('Fields', FIELDS_DATA.merge(ENUM_PROPERTIES_DATA), 'id name')
  # actions_answer = send_to_db('Actions', ACTIONS_DATA, 'id name')
  # fieldtypes_answer = send_to_db('Fieldtypes', ENUMS_DATA.merge(DATATYPES_DATA), 'id name')
  # enum_members_answer = send_to_db('EnumerationMembers', ENUM_MEMBERS_DATA, 'id name',
  #                                  { fieldtypes: fieldtypes_answer })
  # fieldtype_fields_answer = send_to_db('FieldsFieldtypes', FIELDS_DATA.merge(ENUM_PROPERTIES_DATA), 'id',
  #                                      { fieldtypes: fieldtypes_answer, fields: fields_answer })
  # actions_entities_answer = send_to_db('ActionsEntities', ACTIONS_DATA, 'id',
  #                                      { actions: actions_answer, entities: entities_answer })

  # send_field_or_action_to_db('Field', ENTITIES_DATA, { entities: entities_answer, models: fields_answer })
  # send_field_or_action_to_db('Action', ENTITIES_DATA, { entities: entities_answer, models: actions_answer })
  puts 'SCRIPT ENDING'
end
