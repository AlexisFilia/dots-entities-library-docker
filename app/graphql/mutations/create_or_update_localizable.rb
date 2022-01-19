module Mutations
  class CreateOrUpdateLocalizable < Mutations::BaseMutation
    argument :attributes, Types::Input::LocalizableInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::LocalizableType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      if id
        unless attributes[:localizable_type].blank? && attributes[:localizable_id].blank? && attributes[:language].blank? && attributes[:type_of].blank?
          raise GraphQL::ExecutionError,
                "typeOf, language, localizableId and localizableType can't be updated, they need to be blank"
        end
        model.value = attributes[:value]

      else
        if attributes[:localizable_type].blank? || attributes[:localizable_id].blank? || attributes[:value].blank? || attributes[:language].blank? || attributes[:type_of].blank?
          raise GraphQL::ExecutionError,
                "typeOf, language, value, localizableId and localizableType can't be blank for a creation"
        end

        localizable_type = attributes[:localizable_type].upcase_first
        model.attributes = attributes.to_h.except(:localizable_type)
        model.localizable_type = localizable_type
      end
      model.summary = attributes[:value][0...SUMMARY_MAX_LENGTH] if model.type_of == 'description'

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
