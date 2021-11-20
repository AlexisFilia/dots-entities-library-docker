module Types
  module Input
    class TargetLinkInput < Types::BaseInputObject
      argument :entity_id, ID, required: false
      argument :action_model_id, ID, required: false
    end
  end
end
