module Mutations
  class CreateOrUpdateFields < Mutations::BaseMutation
    argument :elements, [Types::Input::FieldsInput], required: true

    type [Types::FieldType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'Field')
        end
      end
      data
    end
  end
end
