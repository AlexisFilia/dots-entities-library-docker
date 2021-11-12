module Types
  class LocalizableType < Types::BaseObject
    field :id, GraphQL::Types::ID, null: false
    field :type_of, String, null: true
    field :language, String, null: true
    field :value, String, null: true
    field :localizable, Types::LocalizableTableType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
