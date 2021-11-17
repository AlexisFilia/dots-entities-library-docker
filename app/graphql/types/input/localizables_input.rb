module Types
  module Input
    class LocalizablesInput < Types::BaseInputObject
      argument :id, GraphQL::Types::ID, required: false
      argument :type_of, String, required: false
      argument :language, String, required: false
      argument :value, String, required: false
      argument :localizable_id, ID, required: false
      argument :localizable_type, Types::LocalizableEnumType, required: false
    end
  end
end
