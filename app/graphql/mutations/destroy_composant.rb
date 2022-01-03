module Mutations
  class DestroyComposant < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: false

    type Types::ComposantType

    def resolve(id:)
      model = Composant.find(id)
      model.destroy
    end
  end
end
