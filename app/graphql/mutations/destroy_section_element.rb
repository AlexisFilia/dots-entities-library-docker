module Mutations
  class DestroySectionElement < Mutations::BaseMutation
    argument :section_id, GraphQL::Types::ID, required: true
    argument :sectionable_id, GraphQL::Types::ID, required: true
    argument :sectionable_type, Types::Enum::SectionTypeEnumType, required: true

    type Types::SectionElementType

    def resolve(**attributes)
      model = SectionElement.find_by!(attributes)
      section = model.section
      section_order = section.order
      section_order.delete(attributes[:sectionable_id])
      section.update!(order: section_order)
      model.destroy
    end
  end
end
