module Mutations
  class CreateOrUpdateDatatypes < Mutations::BaseMutation
    argument :elements, [Types::Input::DatatypesInput], required: true

    type [Types::DatatypeType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << find_or_update_element(element, 'Datatype')
        end
      end
      data
    end
  end
end
