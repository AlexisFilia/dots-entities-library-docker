module Mutations
  class CreateOrUpdateFieldsFieldtypes < Mutations::BaseMutation
    argument :elements, [Types::Input::FieldsFieldtypesInput], required: true

    type [Types::FieldType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_fields_fieldtypes(element)
        end
      end
      data
    end
  end
end
