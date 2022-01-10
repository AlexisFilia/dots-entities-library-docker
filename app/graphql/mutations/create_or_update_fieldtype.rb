module Mutations
  class CreateOrUpdateFieldtype < Mutations::BaseMutation
    argument :attributes, Types::Input::FieldtypeInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::FieldtypeType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      model if model.save!
    end

    def find_or_build_model(id)
      if id
        Fieldtype.find(id)
      else
        Fieldtype.new
      end
    end
  end
end
