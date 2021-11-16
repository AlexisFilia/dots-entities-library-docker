module Types
  module Input
    class FieldOptionsInput < Types::BaseInputObject
      argument :field_model_id, ID, required: true
      argument :optionable_id, ID, required: true
      argument :optionable_type, Types::OptionableEnumType, required: true
    end
  end
end
