module Types
  module Input
    class EntityInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :order, String, required: false
      argument :parent_id, ID, required: false
    end
  end
end
