module Mutations
  class CreateOrUpdateComposant < Mutations::BaseMutation
    argument :attributes, Types::Input::ComposantInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ComposantType

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
        Composant.find(id)
      else
        Composant.new
      end
    end
  end
end
