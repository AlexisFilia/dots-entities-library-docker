module Mutations
  class CreateOrUpdateEnums < Mutations::BaseMutation
    argument :elements, [Types::Input::EnumsInput], required: true

    type [Types::EnumType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'Enum')
        end
      end
      data
    end
  end
end
