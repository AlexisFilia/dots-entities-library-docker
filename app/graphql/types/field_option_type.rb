module Types
  class FieldOptionType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    # field :field_model, Types::FieldModelType, null: true
    field :optionable, Types::FieldOptionTableType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
