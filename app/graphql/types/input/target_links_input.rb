module Types
  module Input
    class TargetLinksInput < Types::BaseInputObject
      argument :id, GraphQL::Types::ID, required: false
      argument :entity_id, ID, required: false
      argument :action_model_id, ID, required: false
    end
  end
end
