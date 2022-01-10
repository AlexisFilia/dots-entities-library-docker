module Types
  module Input
    class EntityInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :child_order, [ID], required: false
      argument :default_fields, [ID], required: false
      argument :default_actions, [ID], required: false
      argument :parent_id, ID, required: false
    end
  end
end
