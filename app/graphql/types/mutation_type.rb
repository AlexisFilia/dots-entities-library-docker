module Types
  class MutationType < Types::BaseObject
    field :createOrUpdateEnum, mutation: Mutations::CreateOrUpdateEnum
    field :createOrUpdateEnums, mutation: Mutations::CreateOrUpdateEnums
    field :createOrUpdateDatatype, mutation: Mutations::CreateOrUpdateDatatype
    field :createOrUpdateDatatypes, mutation: Mutations::CreateOrUpdateDatatypes
    field :createOrUpdateFieldModel, mutation: Mutations::CreateOrUpdateFieldModel
    field :createOrUpdateFieldModels, mutation: Mutations::CreateOrUpdateFieldModels
    field :createOrUpdateActionModel, mutation: Mutations::CreateOrUpdateActionModel
    field :createOrUpdateActionModels, mutation: Mutations::CreateOrUpdateActionModels
    field :create_or_update_entity, mutation: Mutations::CreateOrUpdateEntity
    field :create_or_update_entities, mutation: Mutations::CreateOrUpdateEntities
  end
end
