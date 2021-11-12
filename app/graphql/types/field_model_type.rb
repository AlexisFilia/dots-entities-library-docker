module Types
  class FieldModelType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :code, String, null: true
    field :fields, [Types::FieldType], null: true
    field :options, [Types::FieldOptionTableType], null: true
    field :labels, [Types::LocalizableType], null: true
    field :descriptions, [Types::LocalizableType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
