module Mutations
  class DestroyLocalizable < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: false

    type Types::LocalizableType

    def resolve(id:)
      model = Localizable.find(id)
      model.destroy
    end
  end
end
