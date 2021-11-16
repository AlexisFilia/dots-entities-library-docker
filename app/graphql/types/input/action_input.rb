module Types
  module Input
    class ActionInput < Types::BaseInputObject
      argument :is_default, Boolean, required: false
      argument :action_model_id, ID, required: true
      argument :section_id, ID, required: true
    end
  end
end
