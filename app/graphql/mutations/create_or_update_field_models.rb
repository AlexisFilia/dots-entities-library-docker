module Mutations
  class CreateOrUpdateFieldModels < Mutations::BaseMutation
    argument :elements, [Types::Input::FieldModelsInput], required: true

    type [Types::FieldModelType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'FieldModel')
        end
      end
      data
    end
  end
end
