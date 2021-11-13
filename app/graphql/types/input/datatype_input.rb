module Types
  module Input
    class DatatypeInput < Types::BaseInputObject
      argument :name, String, required: false
    end
  end
end