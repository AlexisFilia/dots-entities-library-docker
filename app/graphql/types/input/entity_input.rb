module Types
  module Input
    class EntityInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :order, String, required: false
      argument :ancestry, String, required: false
    end
  end
end