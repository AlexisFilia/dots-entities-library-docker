module Types
  module Input
    class ToggleDefaultsInput < Types::BaseInputObject
      argument :entity_id, ID, required: false
      argument :element_id, ID, required: false
      argument :element_type, Types::Enum::SectionTypeEnumType, required: false
    end
  end
end
