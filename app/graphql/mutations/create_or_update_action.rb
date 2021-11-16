module Mutations
  class CreateOrUpdateAction < Mutations::BaseMutation
    argument :attributes, Types::Input::ActionInput, required: true
    argument :id, GraphQL::Types::ID, required: false

    type Types::ActionType

    def resolve(attributes:, id: nil)
      model = find_or_build_model(id)
      ActiveRecord::Base.transaction do
        previous_section_id = model.section.blank? ? nil : model.section.id
        model.attributes = attributes.to_h.except(:section_id)

        if model.save
          { field: model }
        else
          { errors: model.errors.full_messages }
        end

        if id.blank?
          section = Section.find(attributes.section_id)
          check_section_type(section, model)
          order = JSON.parse(section.order)
          order << model.id
          section.update(order: order)
          SectionElement.create(section: section, sectionable: model)
        elsif previous_section_id != attributes.section_id
          previous_section = Section.find(previous_section_id)
          previous_section_order = JSON.parse(previous_section.order)
          previous_section_order.delete(model.id)
          previous_section.update(order: previous_section_order)
          new_section = Section.find(attributes.section_id)
          check_section_type(new_section, model)
          new_section_order = JSON.parse(new_section.order)
          new_section_order << model.id
          new_section.update(order: new_section_order)
          section_element = SectionElement.find_by(section: previous_section, sectionable: model)
          section_element.update(section: new_section, sectionable: model)
        end
      end

      model.reload
    end

    def find_or_build_model(id)
      if id
        Action.find(id)
      else
        Action.new
      end
    end
  end
end
