module Types
  module Input
    class FieldInput < Types::BaseInputObject
      argument :is_default, Boolean, required: false
      argument :field_model_id, ID, required: true
      argument :section_id, ID, required: true
    end
  end
end
