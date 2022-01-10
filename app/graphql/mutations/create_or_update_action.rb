module Mutations
  class CreateOrUpdateAction < Mutations::BaseMutation
    argument :attributes, Types::Input::ActionInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ActionType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      ActiveRecord::Base.transaction do
        # previous_section_id = model.section.blank? ? nil : model.section.id
        model.attributes = attributes.to_h.except(:section_id)

        model if model.save!
      end

      # model.reload
    end

    def find_or_build_model(id)
      if id
        Action.find(id)
      else
        Action.new
      end
    end
  end
end
