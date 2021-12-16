module Types
  module Input
    class ActionsEntitiesInput < Types::BaseInputObject
      argument :id, GraphQL::Types::ID, required: false
      argument :entity_id, ID, required: false
      argument :action_id, ID, required: false
    end
  end
end
