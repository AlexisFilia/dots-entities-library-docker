module Mutations
  class CreateOrUpdateEntity < Mutations::BaseMutation
    argument :attributes, Types::Input::EntityInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::EntityType

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
        Entity.find(id)
      else
        Entity.new
      end
    end
  end
end
