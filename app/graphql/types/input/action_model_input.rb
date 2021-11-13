module Types
  module Input
    class ActionModelInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :inverse, String, required: false
      argument :main, String, required: false
    end
  end
end