module Types
  class ActionsEntityType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :action, Types::ActionType, null: true
    field :entity, Types::EntityType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
