module Types
  module Input
    class EntitiesInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :order, String, required: false
      argument :parent_id, ID, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
