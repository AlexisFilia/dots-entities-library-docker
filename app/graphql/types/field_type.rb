module Types
  class FieldType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :is_default, String, null: true
    field :field_model, Types::FieldModelType, null: true
    field :section, Types::SectionType, null: true
    field :labels, [Types::LocalizableType], null: true
    field :descriptions, [Types::LocalizableType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
