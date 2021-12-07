module Types
  class EntityType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :order, [GraphQL::Types::ID], null: true
    field :sections, [Types::SectionType], null: true
    field :fields, [Types::FieldType], null: true
    field :actions, [Types::ActionType], null: true
    field :target_of, [Types::ActionModelType], null: true
    field :action_models, [Types::ActionModelType], null: true
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
