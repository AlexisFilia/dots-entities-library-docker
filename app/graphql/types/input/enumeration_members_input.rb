module Types
  module Input
    class EnumerationMembersInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :fieldtype_id, ID, required: true
      argument :id, GraphQL::Types::ID, required: false
    end
  end
end
