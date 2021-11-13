module Types
  module Input
    class EnumerationMemberInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :enum_id, ID, required: false
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
