module Mutations
  class CreateOrUpdateActionsEntities < Mutations::BaseMutation
    argument :elements, [Types::Input::ActionsEntitiesInput], required: true

    type [Types::ActionsEntityType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          if element[:id]

          else
            action = Action.find(element[:action_id])
            entity = Entity.find(element[:entity_id])
            action.entities << entity
          end
          response << entity
        end
      end
      response
    end
  end
end
