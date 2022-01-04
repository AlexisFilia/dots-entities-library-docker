module Types
  class EntityType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :child_order, [GraphQL::Types::ID], null: true
    field :default_fields, [GraphQL::Types::ID], null: true
    field :default_actions, [GraphQL::Types::ID], null: true
    field :sections, [Types::SectionType], null: true
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

    field :labels, [Types::LocalizableType], null: true do
      argument :language_is, String, required: false, default_value: nil
    end

    field :descriptions, [Types::LocalizableType], null: true do
      argument :language_is, String, required: false, default_value: nil
    end
  end
end
