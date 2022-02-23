# def load_file_from_web(url)
#   JSON.load(open(url))
# end

# def still_used?(element)
#   element['schema:supersededBy'].nil?
# end

# def get_name(element)
#   return 'ISSUE' if element['@id'].blank?
#   return element['@id'].match(/schema:(.*)/)[1] unless element['@id'].match(/schema:(.*)/).nil?
#   return element['@id'].match(/rdfs:(.*)/)[1] unless element['@id'].match(/rdfs:(.*)/).nil?

#   element['@id']
# end

# def transform_in_array(element)
#   if element.is_a?(Array)
#     element
#   else
#     [element]
#   end
# end

# def is_entity?(element)
#   element['@type'] == 'rdfs:Class'
# end

# def is_pur_datatype_element?(element)
#   element['@id'] == 'schema:DataType'
# end

# def is_datatype_element?(element)
#   array = transform_in_array(element['@type'])
#   (array & ['rdfs:Class', 'schema:DataType']).length == 2
# end

# def is_a_sub_datatype?(element)
#   return true if DATATYPES.find { |datatype| datatype[:name] == get_name(element['@type']) }
#   return false if element['rdfs:subClassOf'].nil?

#   array = transform_in_array(element['rdfs:subClassOf'])
#   array.each do |e|
#     return true if DATATYPES.find { |datatype| datatype[:name] == get_name(e['@id']) }
#   end
#   false
# end

# def is_datatype?(element)
#   is_pur_datatype_element?(element) || is_datatype_element?(element) || is_a_sub_datatype?(element)
# end

# def is_enum_from_enumerable?(element)
#   return false unless element['@type'] == 'rdfs:Class'
#   return false if element['rdfs:subClassOf'].nil?

#   array = transform_in_array(element['rdfs:subClassOf'])
#   array.each do |e|
#     return true unless e['@id'].match(/schema:(.*)Enumeration/).nil?
#   end
#   false
# end

# def is_enum_child_from_enumerable?(element)
#   return false unless element['@type'] == 'rdfs:Class'
#   return false if element['rdfs:subClassOf'].nil?

#   array = transform_in_array(element['rdfs:subClassOf'])
#   array.each do |e|
#     return true if ENUMS.find { |datatype| datatype[:name] == get_name(e['@id']) }
#   end
#   false
# end

# def is_enum?(element)
#   is_enum_from_enumerable?(element) || is_enum_child_from_enumerable?(element)
# end
