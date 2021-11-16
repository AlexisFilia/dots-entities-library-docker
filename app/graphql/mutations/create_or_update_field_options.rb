module Mutations
  class CreateOrUpdateFieldOptions < Mutations::BaseMutation
    argument :elements, [Types::Input::FieldOptionsInput], required: true

    type [Types::FieldOptionType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          if element[:id]
            data = FieldOption.find(element[:id])
            data.update(element.to_h.except(:id))
          elsif FieldOption.exists?(field_model_id: element[:field_model_id])
            data = FieldOption.find_by(field_model_id: element[:field_model_id])
            data.update(element.to_h.except(:field_model_id))
          else
            data = FieldOption.create!(element.to_h)
          end
          response << data
        end
      end
      response
    end
  end
end
