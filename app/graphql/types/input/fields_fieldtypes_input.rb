module Types
  module Input
    class FieldsFieldtypesInput < Types::BaseInputObject
      argument :id, GraphQL::Types::ID, required: false
      argument :field_id, ID, required: true
      argument :fieldtype_id, ID, required: true
    end
  end
end
