module Mutations
  class CreateOrUpdateActionModel < Mutations::BaseMutation
    argument :attributes, Types::Input::ActionModelInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ActionModelType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { action_model: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        ActionModel.find(id)
      else
        ActionModel.new
      end
    end
  end
end
