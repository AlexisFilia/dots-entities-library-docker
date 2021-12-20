module Mutations
  class CreateOrUpdateSectionElements < Mutations::BaseMutation
    argument :elements, [Types::Input::SectionElementsInput], required: true

    type [Types::SectionElementType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_section_elements(element)
        end
      end
      data
    end
  end
end
