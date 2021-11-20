module Mutations
  class CreateOrUpdateTargetLinks < Mutations::BaseMutation
    argument :elements, [Types::Input::TargetLinksInput], required: true

    type [Types::TargetLinkType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          if element[:id]
            data = TargetLink.find(element[:id])
            data.update(element.to_h.except(:id))
          elsif TargetLink.exists?(entity_id: element[:entity_id], action_model_id: element[:action_model_id])
            data = TargetLink.find_by(entity_id: element[:entity_id], action_model_id: element[:action_model_id])
            data.update(element.to_h.except(:entity_id, :action_model_id))
          else
            data = TargetLink.create!(element.to_h)
          end
          response << data
        end
      end
      response
    end
  end
end
