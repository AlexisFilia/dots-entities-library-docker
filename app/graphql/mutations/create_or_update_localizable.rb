module Mutations
  class CreateOrUpdateLocalizable < Mutations::BaseMutation
    argument :attributes, Types::Input::LocalizableInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::LocalizableType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { entity: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        Localizable.find(id)
      else
        Localizable.new
      end
    end
  end
end
