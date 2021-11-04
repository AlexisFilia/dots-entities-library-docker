module Types
  class ActionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :labels, String, null: true
    field :descriptions, String, null: true
    field :inverse, String, null: true
    field :main, String, null: true
    field :agents, [Types::EntityType], null: true
    field :targets, [Types::EntityType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
