module Mutations
  class CreateOrUpdateSection < Mutations::BaseMutation
    argument :attributes, Types::Input::SectionInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::SectionType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      pp attributes[:entity_id]
      pp model.entity_id
      unless model.id.blank? || model.entity_id == attributes[:entity_id].to_i
        raise GraphQL::ExecutionError,
              "You can't link this section to an other entity"
      end

      model.attributes = attributes.to_h
      ActiveRecord::Base.transaction do
        order_to_update = model.id.blank? ? true : false

        if model.save
          if order_to_update
            entity = Entity.find(attributes[:entity_id])
            order = entity.order
            order << model.id
            entity.update!(order: order)
          end
          model
        else
          model.errors.full_messages
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
