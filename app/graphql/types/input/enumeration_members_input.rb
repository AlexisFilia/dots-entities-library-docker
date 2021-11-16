module Types
  module Input
    class EnumerationMembersInput < Types::BaseInputObject
      argument :enum_id, ID, required: true
      argument :name, String, required: false
    end
  end
end
