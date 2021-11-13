module Types
  module Input
    class SectionInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :order, String, required: false
      argument :entity_id, ID, required: false
    end
  end
end
