module Types
  module Input
    class FieldtypesInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
