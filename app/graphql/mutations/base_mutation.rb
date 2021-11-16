module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def create_or_update_element(element, klass)
      if element[:id]
        data = eval(klass).find(element[:id])
        data.update(element.to_h.except(:id))
      elsif element[:name]
        if eval(klass).exists?(name: element[:name])
          data = eval(klass).find_by(name: element[:name])
          data.update(element.to_h.except(:name))
        else
          data = eval(klass).create!(element.to_h)
        end
      end
      data
    end
  end
end
