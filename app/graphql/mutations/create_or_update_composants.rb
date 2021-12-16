module Mutations
  class CreateOrUpdateComposants < Mutations::BaseMutation
    argument :elements, [Types::Input::ComposantsInput], required: true

    type [Types::ComposantType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'Composant')
        end
      end
      data
    end
  end
end
