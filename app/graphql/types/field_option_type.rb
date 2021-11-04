module Types
  class FieldOptionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :field, Types::FieldType, null: true
    field :option, Types::OptionTableType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
