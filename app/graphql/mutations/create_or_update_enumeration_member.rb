module Mutations
  class CreateOrUpdateEnumerationMember < Mutations::BaseMutation
    argument :attributes, Types::Input::EnumerationMemberInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::EnumerationMemberType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      if model.save
        { enumeration_member: model }
      else
        { errors: model.errors.full_messages }
      end
      model
    end

    def find_or_build_model(id)
      if id
        EnumerationMember.find(id)
      else
        EnumerationMember.new
      end
    end
  end
end
