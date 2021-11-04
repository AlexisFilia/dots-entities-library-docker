module Types
  class FieldType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :labels, String, null: true
    field :descriptions, String, null: true
    field :entities, [Types::EntityType], null: true
    field :enums, [Types::EnumType], null: true
    field :datatypes, [Types::DatatypeType], null: true
    field :options, [Types::OptionTableType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
