module Mutations
  class CreateOrUpdateField < Mutations::BaseMutation
    argument :attributes, Types::Input::FieldInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::FieldType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      ActiveRecord::Base.transaction do
        # previous_section_id = model.section.blank? ? nil : model.section.id
        model.attributes = attributes.to_h.except(:section_id)

        model if model.save!

        # if id.blank?
        #   section = Section.find(attributes.section_id)
        #   check_section_type(section, model)
        #   child_order = section.child_order
        #   child_order << model.id
        #   section.update(child_order: child_order)
        #   SectionElement.create(section: section, sectionable: model)
        # elsif previous_section_id != attributes.section_id
        #   previous_section = Section.find(previous_section_id)
        #   previous_section_child_order = previous_section.child_order
        #   previous_section_child_order.delete(model.id)
        #   previous_section.update(child_order: previous_section_child_order)
        #   new_section = Section.find(attributes.section_id)
        #   check_section_type(new_section, model)
        #   new_section_child_order = new_section.child_order
        #   new_section_child_order << model.id
        #   new_section.update(child_order: new_section_child_order)
        #   section_element = SectionElement.find_by(section: previous_section, sectionable: model)
        #   section_element.update(section: new_section, sectionable: model)
        # end
      end

      # model.reload
    end

    def find_or_build_model(id)
      if id
        Field.find(id)
      else
        Field.new
      end
    end
  end
end
