module Mutations
  class CreateOrUpdateFieldModel < Mutations::BaseMutation
    argument :attributes, Types::Input::FieldModelInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::FieldModelType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { field_model: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        FieldModel.find(id)
      else
        FieldModel.new
      end
    end
  end
end
