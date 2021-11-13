module Types
  module Input
    class EnumInput < Types::BaseInputObject
      argument :name, String, required: false
    end
  end
end