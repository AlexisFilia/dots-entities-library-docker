module Types
  module Input
    class FieldInput < Types::BaseInputObject
      argument :name, String, required: true
    end
  end
end
