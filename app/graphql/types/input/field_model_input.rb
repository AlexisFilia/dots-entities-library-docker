module Types
  module Input
    class FieldModelInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :code, String, required: false
    end
  end
end