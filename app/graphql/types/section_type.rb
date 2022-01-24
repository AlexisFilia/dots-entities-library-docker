module Types
  class SectionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :label, String, null: true
    field :description, String, null: true
    field :description_summary, String, null: true
    field :child_order, [GraphQL::Types::ID], null: true
    field :entity, Types::EntityType, null: true
    field :element_type, String, null: true
    field :elements, [Types::SectionOptionTableType], null: true
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
