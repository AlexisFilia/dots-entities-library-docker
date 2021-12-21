module Mutations
  class ToggleDefault < Mutations::BaseMutation
    argument :attributes, Types::Input::ToggleDefaultsInput, required: true

    type Types::EntityType

    def resolve(attributes:)
      entity = Entity.find(attributes[:entity_id])
      element = attributes[:element_type].constantize.find(attributes[:element_id])
      check_element_presence_for_entity(entity, element)

      default_elements = entity.send("default_#{element.class.name.downcase}s")
      if default_elements.include?(element.id)
        default_elements.delete(element.id)
      else
        default_elements << element.id
      end
      entity.update("default_#{element.class.name.downcase}s" => default_elements)
      entity
    end

    def check_element_presence_for_entity(entity, element)
      unless entity.elements.include?(element)
        raise GraphQL::ExecutionError,
              'This element is not part of this entity'
      end
    end
  end
end
