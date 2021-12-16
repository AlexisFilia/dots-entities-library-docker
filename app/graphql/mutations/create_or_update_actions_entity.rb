module Mutations
  class CreateOrUpdateActionsEntity < Mutations::BaseMutation
    argument :attributes, Types::Input::ActionsEntityInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ActionsEntityType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { localizable: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        ActionsEntity.find(id)
      else
        ActionsEntity.new
      end
    end
  end
end
