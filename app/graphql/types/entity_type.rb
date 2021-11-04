module Types
  class EntityType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :labels, String, null: true
    field :descriptions, String, null: true
    field :setting, Types::SettingType, null: true
    field :fields, [Types::FieldType], null: true
    field :actions, [Types::ActionType], null: true
    field :target_of, [Types::ActionType], null: true
    field :parent, Types::EntityType, null: true
    field :children, [Types::EntityType], null: true
    field :ancestors, [Types::EntityType], null: true
    field :descendants, [Types::EntityType], null: true
    field :siblings, [Types::EntityType], null: true
    field :subtree, [Types::EntityType], null: true
    field :path, [Types::EntityType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
