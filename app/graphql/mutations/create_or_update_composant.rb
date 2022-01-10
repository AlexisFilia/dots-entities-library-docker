module Mutations
  class CreateOrUpdateComposant < Mutations::BaseMutation
    argument :attributes, Types::Input::ComposantInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ComposantType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      model if model.save!
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
