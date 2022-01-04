module Mutations
  class DestroySection < Mutations::BaseMutation
    argument :id, GraphQL::Types::ID, required: true

    type Types::SectionType

    def resolve(id:)
      model = Section.find(id)
      if model.name == 'fieldsRootSection' || model.name == 'actionsRootSection'
        raise GraphQL::ExecutionError,
              "You can't destroy 'fieldsRootSection' or 'actionsRootSection'"
      end
      entity = model.entity
      entity_child_order = entity.child_order
      entity_child_order.delete(model.id)
      entity.update(child_order: entity_child_order)
      model.destroy
    end
  end
end
