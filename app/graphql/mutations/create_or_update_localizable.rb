module Mutations
  class CreateOrUpdateLocalizable < Mutations::BaseMutation
    argument :attributes, Types::Input::LocalizableInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::LocalizableType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      localizable_type = attributes[:localizable_type].upcase_first
      model.attributes = attributes.to_h.except(:localizable_type)
      model.localizable_type = localizable_type

      model if model.save!
    end

    def find_or_build_model(id)
      if id
        Localizable.find(id)
      else
        Localizable.new
      end
    end
  end
end
