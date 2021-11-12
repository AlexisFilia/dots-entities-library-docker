module Types
  class DatatypeType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :field_models, [Types::FieldModelType], null: true
    field :labels, [Types::LocalizableType], null: true
    field :descriptions, [Types::LocalizableType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
