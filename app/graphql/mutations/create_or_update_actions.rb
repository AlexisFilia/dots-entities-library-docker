module Mutations
  class CreateOrUpdateActions < Mutations::BaseMutation
    argument :elements, [Types::Input::ActionsInput], required: true

    type [Types::ActionType]

    def resolve(elements:)
      data = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          data << create_or_update_properties(element, 'Action')
        end
      end
      data
    end
  end
end
