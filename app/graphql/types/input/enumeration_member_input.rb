module Types
  module Input
    class EnumerationMemberInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :fieldtype_id, ID, required: false
    end
  end
end
