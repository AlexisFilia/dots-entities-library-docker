module Mutations
  class CreateOrUpdateEnum < Mutations::BaseMutation
    argument :attributes, Types::Input::EnumInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::EnumType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { enum: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        Enum.find(id)
      else
        Enum.new
      end
    end
  end
end
