module Mutations
  class CreateOrUpdateEnumerationMembers < Mutations::BaseMutation
    argument :elements, [Types::Input::EnumerationMembersInput], required: true

    type [Types::EnumerationMemberType]

    def resolve(elements:)
      response = []
      ActiveRecord::Base.transaction do
        elements.each do |element|
          if element[:id]
            data = EnumerationMember.find(element[:id])
            data.update(element.to_h.except(:id))
          elsif EnumerationMember.exists?(name: element[:name])
            data = EnumerationMember.find_by(name: element[:name])
            data.update(element.to_h.except(:name))
          else
            data = EnumerationMember.create(element.to_h)
          end
          response << data
        end
      end
      response
    end
  end
end
