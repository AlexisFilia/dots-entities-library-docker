module Mutations
  class CreateOrUpdateEnumerationMember < Mutations::BaseMutation
    argument :attributes, Types::Input::EnumerationMemberInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::EnumerationMemberType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      model.attributes = attributes.to_h

      model if model.save!
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
