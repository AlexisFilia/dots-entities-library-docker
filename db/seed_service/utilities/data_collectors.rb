# def collect_entities(data_hash)
#   data_hash['@graph'].each do |element|
#     next unless still_used?(element) || WITH_SUPERSEDED
#     next unless is_entity?(element)

#     ENTITIES << {
#       name: get_name(element),
#       created_at: DateTime.now,
#       updated_at: DateTime.now
#     }
#   end
# end

# def collect_datatypes(data_hash)
#   data_hash['@graph'].each do |element|
#     next unless still_used?(element) || WITH_SUPERSEDED
#     next unless is_datatype?(element)

#     DATATYPES << {
#       name: get_name(element),
#       type_of: 'Datatype',
#       created_at: DateTime.now,
#       updated_at: DateTime.now
#     }
#   end
# end

# def collect_enums(data_hash)
#   data_hash['@graph'].each do |element|
#     next unless still_used?(element) || WITH_SUPERSEDED
#     next unless is_enum?(element)

#     ENUMS << {
#       name: get_name(element),
#       type_of: 'Enum',
#       created_at: DateTime.now,
#       updated_at: DateTime.now
#     }
#   end
# end

# # def collect_fields(data_hash)
# #   data_hash['@graph'].each do |element|
# #     next unless still_used?(element) || WITH_SUPERSEDED
# #     next unless is_field?(element)
# #   end
# # end

# # def collect_actions(data_hash)
# #   data_hash['@graph'].each do |element|
# #     next unless still_used?(element) || WITH_SUPERSEDED
# #   end
# # end
