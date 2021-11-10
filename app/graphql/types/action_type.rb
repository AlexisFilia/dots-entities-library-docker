module Types
  class ActionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :is_default, String, null: true
    field :agent_model, Types::ActionType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
