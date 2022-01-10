module Mutations
  class CreateOrUpdateLocalizables < Mutations::BaseMutation
    argument :elements, [Types::Input::LocalizablesInput], required: true

    type [Types::LocalizableType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          localizable_type = element[:localizable_type].upcase_first

          if element[:id]
            data = Localizable.find(element[:id])
            data.update(element.to_h.except(:id))
          elsif Localizable.exists?(type_of: element[:type_of], localizable_id: element[:localizable_id],
                                    localizable_type: localizable_type, language: element[:language])
            data = Localizable.find_by(type_of: element[:type_of], localizable_id: element[:localizable_id],
                                       localizable_type: localizable_type, language: element[:language])
            data.update(element.to_h.except(:type_of, :localizable_id, :localizable_type, :language))
          else
            data = Localizable.new(element.to_h.except(:localizable_type))
            data.localizable_type = localizable_type
            data.save!
          end
          response << data
        end
      end
      response
    end
  end
end
