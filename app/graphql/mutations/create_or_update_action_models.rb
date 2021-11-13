module Mutations
  class CreateOrUpdateActionModels < Mutations::BaseMutation
    argument :elements, [Types::Input::ActionModelsInput], required: true

    type [Types::ActionModelType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << find_or_update_element(element, 'ActionModel')
        end
      end
      data
    end
  end
end
