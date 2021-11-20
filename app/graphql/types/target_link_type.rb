module Types
  class TargetLinkType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :entity, Types::EntityType, null: true
    field :action_model, Types::ActionModelType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
