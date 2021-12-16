module Types
  module Input
    class ActionsInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :inverse, String, required: false
      argument :main, String, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
