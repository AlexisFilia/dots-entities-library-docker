module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_section_type(section, model)
      unless section.element_type == model.class.name
        raise GraphQL::ExecutionError,
              'This section does not accept this type of element'
      end
    end

    def create_or_update_element(element, klass)
      if element[:id]
        data = eval(klass).find(element[:id])
        data.update(element.to_h.except(:id))
      elsif element[:name]
        if eval(klass).exists?(name: element[:name])
          data = eval(klass).find_by(name: element[:name])
          data.update(element.to_h.except(:name))
        else
          data = eval(klass).create!(element.to_h)
        end
      end
      data
    end

    def create_or_update_properties(element, klass)
      model = if element[:id]
                eval(klass).find(element[:id])
              else
                eval(klass).new
              end
      previous_section_id = model.section.blank? ? nil : model.section.id
      model.attributes = element.to_h.except(:id, :section_id)

      if model.save
        hash = {}
        hash[klass.downcase.to_sym] = model
      else
        { errors: model.errors.full_messages }
      end

      if element[:id].blank?
        section = Section.find(element.section_id)
        check_section_type(section, model)
        order = section.order
        order << model.id
        section.update(order: order)
        SectionElement.create(section: section, sectionable: model)
      elsif previous_section_id != element.section_id
        previous_section = Section.find(previous_section_id)
        previous_section_order = previous_section.order
        previous_section_order.delete(model.id)
        previous_section.update(order: previous_section_order)
        new_section = Section.find(element.section_id)
        check_section_type(new_section, model)
        new_section_order = new_section.order
        new_section_order << model.id
        new_section.update(order: new_section_order)
        section_element = SectionElement.find_by(section: previous_section, sectionable: model)
        section_element.update(section: new_section, sectionable: model)
      end
      model.reload
    end

    def create_or_update_fields_fieldtypes(element)
      if element[:id]

      else
        field = Field.find(element[:field_id])
        fieldtype = Fieldtype.find(element[:fieldtype_id])
        field.fieldtypes << fieldtype
      end
      field
    end

    def create_or_update_section_elements(element)
      section = Section.find(element[:section_id])
      model = element[:type_of].constantize.find(element[:element_id])
      if element[:id].blank?
        check_section_type(section, model)
        order = section.order
        order << element[:element_id]
        section.update(order: order)
        SectionElement.create!(section: section, sectionable: model)
      else
        previous_section_id = SectionElement.find(element[:id]).section_id
        if previous_section_id != element[:section_id]
          previous_section = Section.find(previous_section_id)
          previous_section_order = previous_section.order
          previous_section_order.delete(element[:element_id])
          previous_section.update(order: previous_section_order)
          check_section_type(section, model)
          section_order = section.order
          section_order << element[:element_id]
          section.update(order: section_order)
          section_element = SectionElement.find_by(section: previous_section, sectionable: model)
          section_element.update(section: section, sectionable: model)
        end
      end
    end
  end
end
