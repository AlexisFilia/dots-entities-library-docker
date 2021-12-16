module Types
  module Input
    class ComposantsInput < Types::BaseInputObject
      argument :code, String, required: false
      argument :field_id, ID, required: true
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
