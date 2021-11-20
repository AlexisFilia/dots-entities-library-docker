module Mutations
  class CreateOrUpdateTargetLink < Mutations::BaseMutation
    argument :attributes, Types::Input::TargetLinkInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::TargetLinkType

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
        TargetLink.find(id)
      else
        TargetLink.new
      end
    end
  end
end
