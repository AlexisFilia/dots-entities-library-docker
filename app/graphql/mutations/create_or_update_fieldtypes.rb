module Mutations
  class CreateOrUpdateFieldtypes < Mutations::BaseMutation
    argument :elements, [Types::Input::FieldtypesInput], required: true

    type [Types::FieldtypeType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'Fieldtype')
        end
      end
      data
    end
  end
end
