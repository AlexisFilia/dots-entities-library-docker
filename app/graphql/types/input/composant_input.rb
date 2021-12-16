module Types
  module Input
    class ComposantInput < Types::BaseInputObject
      argument :code, String, required: false
      argument :field_id, ID, required: true
    end
  end
end
