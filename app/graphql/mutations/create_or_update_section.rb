module Mutations
  class CreateOrUpdateSection < Mutations::BaseMutation
    argument :attributes, Types::Input::SectionInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::SectionType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      unless model.id.blank? || model.entity_id == attributes[:entity_id].to_i || attributes[:entity_id].blank?
        raise GraphQL::ExecutionError,
              "You can't link this section to an other entity"
      end
      unless model.element_type.blank? || model.element_type == attributes[:element_type] || attributes[:element_type].blank?
        raise GraphQL::ExecutionError,
              "You can't change the element_type once it's defined"
      end
      if model.name == 'fieldsRootSection' || model.name == 'actionsRootSection'
        raise GraphQL::ExecutionError,
              "You can't changeb 'fieldsRootSection' or 'actionsRootSection' name"
      end
      if attributes[:name] == 'fieldsRootSection' || attributes[:name] == 'actionsRootSection'
        raise GraphQL::ExecutionError,
              "You can't use 'fieldsRootSection' or 'actionsRootSection' as a name for your sections"
      end

      model.attributes = attributes.to_h
      ActiveRecord::Base.transaction do
        child_order_to_update = model.id.blank? ? true : false

        if model.save!
          if child_order_to_update
            entity = Entity.find(attributes[:entity_id])
            child_order = entity.child_order
            child_order << model.id
            entity.update!(child_order: child_order)
          end
          model
        end
      end
    end

    def find_or_build_model(id)
      if id
        Section.find(id)
      else
        Section.new
      end
    end
  end
end
