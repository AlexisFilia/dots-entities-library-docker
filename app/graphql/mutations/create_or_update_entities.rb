module Mutations
  class CreateOrUpdateEntities < Mutations::BaseMutation
    argument :elements, [Types::Input::EntitiesInput], required: true

    type [Types::EntityType]

    def resolve(elements: [])
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_element(element, 'Entity')
        end
      end
      data
    end
  end
end
