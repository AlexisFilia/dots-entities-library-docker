module Types
  class SectionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :name, String, null: true
    field :order, String, null: true
    field :entity, Types::EntityType, null: true
    field :element_type, String, null: true
    field :elements, [Types::SectionOptionTableType], null: true
    field :section_elements, [Types::SectionElementType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
