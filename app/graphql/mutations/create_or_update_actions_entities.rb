module Mutations
  class CreateOrUpdateActionsEntities < Mutations::BaseMutation
    argument :elements, [Types::Input::ActionsEntitiesInput], required: true

    type [Types::ActionsEntityType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          if element[:id]
            data = ActionsEntity.find(element[:id])
            data.update(element.to_h.except(:id))
          elsif ActionsEntity.exists?(entity_id: element[:entity_id], action_model_id: element[:action_model_id])
            data = ActionsEntity.find_by(entity_id: element[:entity_id], action_model_id: element[:action_model_id])
            data.update(element.to_h.except(:entity_id, :action_model_id))
          else
            data = ActionsEntity.create!(element.to_h)
          end
          response << data
        end
      end
      response
    end
  end
end
