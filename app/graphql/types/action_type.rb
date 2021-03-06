module Types
  class ActionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :inverse, String, null: true
    field :main, String, null: true
    field :label, String, null: true
    field :description, String, null: true
    field :description_summary, String, null: true
    field :section, Types::SectionType, null: true
    field :entities, [Types::EntityType], null: true
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
