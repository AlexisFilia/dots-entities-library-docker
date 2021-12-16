module Types
  module Input
    class ActionsEntityInput < Types::BaseInputObject
      argument :entity_id, ID, required: false
      argument :action_id, ID, required: false
    end
  end
end
