module Types
  module Input
    class FieldtypesInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :type_of, Types::Enum::FieldtypeEnumType, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
