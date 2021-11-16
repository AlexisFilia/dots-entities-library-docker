module Types
  module Input
    class ActionsInput < Types::BaseInputObject
      argument :is_default, Boolean, required: false
      argument :action_model_id, ID, required: false
      argument :section_id, ID, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
