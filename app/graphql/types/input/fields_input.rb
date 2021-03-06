module Types
  module Input
    class FieldsInput < Types::BaseInputObject
      argument :name, String, required: true
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
