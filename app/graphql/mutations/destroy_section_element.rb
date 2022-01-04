module Mutations
  class DestroySectionElement < Mutations::BaseMutation
    argument :section_id, GraphQL::Types::ID, required: true
    argument :sectionable_id, GraphQL::Types::ID, required: true
    argument :sectionable_type, Types::Enum::SectionTypeEnumType, required: true

    type Types::SectionElementType

    def resolve(**attributes)
      attributes[:sectionable_type] = attributes[:sectionable_type].upcase_first
      model = SectionElement.find_by!(attributes)
      section = model.section
      section_child_order = section.child_order
      section_child_order.delete(attributes[:sectionable_id])
      section.update!(child_order: section_child_order)
      model.destroy
    end
  end
end
