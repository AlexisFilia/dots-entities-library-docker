module Types
  module Input
    class FieldsInput < Types::BaseInputObject
      argument :is_default, Boolean, required: false
      argument :field_model_id, ID, required: false
      argument :section_id, ID, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
