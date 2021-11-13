module Types
  module Input
    class FieldModelsInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :code, String, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
