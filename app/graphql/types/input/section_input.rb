module Types
  module Input
    class SectionInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :entity_id, ID, required: false
      argument :element_type, Types::Enum::SectionTypeEnumType, required: false
    end
  end
end
