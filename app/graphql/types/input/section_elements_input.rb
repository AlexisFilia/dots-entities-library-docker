module Types
  module Input
    class SectionElementsInput < Types::BaseInputObject
      argument :section_id, ID, required: false
      argument :element_id, ID, required: false
      argument :type_of, Types::Enum::SectionTypeEnumType, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
