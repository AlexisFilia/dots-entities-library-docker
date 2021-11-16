module Mutations
  class CreateOrUpdateSection < Mutations::BaseMutation
    argument :attributes, Types::Input::SectionInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::SectionType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { section: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        Section.find(id)
      else
        Section.new
      end
    end
  end
end
