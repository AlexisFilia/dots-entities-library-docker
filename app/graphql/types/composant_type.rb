module Types
  class ComposantType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :code, String, null: true
    field :field, [Types::FieldType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
