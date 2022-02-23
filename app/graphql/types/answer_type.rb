module Types
  class AnswerType < Types::BaseObject
    field :status, Int, null: true
    field :message, String, null: true
    # field :errors, [String], null: true
    # field :data, [String], null: true
  end
end
