module Types
  class SectionElementType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :section, Types::SectionType, null: true
    field :option, Types::SectionOptionTableType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
