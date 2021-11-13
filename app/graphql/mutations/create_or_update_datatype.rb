module Mutations
  class CreateOrUpdateDatatype < Mutations::BaseMutation
    argument :attributes, Types::Input::DatatypeInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::DatatypeType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { datatype: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        Datatype.find(id)
      else
        Datatype.new
      end
    end
  end
end
