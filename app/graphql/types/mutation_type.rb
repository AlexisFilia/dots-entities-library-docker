module Types
  class MutationType < Types::BaseObject
    field :create_or_update_enum, mutation: Mutations::CreateOrUpdateEnum
    field :create_or_update_enums, mutation: Mutations::CreateOrUpdateEnums
    field :create_or_update_datatype, mutation: Mutations::CreateOrUpdateDatatype
    field :create_or_update_datatypes, mutation: Mutations::CreateOrUpdateDatatypes
    field :create_or_update_field_model, mutation: Mutations::CreateOrUpdateFieldModel
    field :create_or_update_field_models, mutation: Mutations::CreateOrUpdateFieldModels
    field :create_or_update_field, mutation: Mutations::CreateOrUpdateField
    field :create_or_update_fields, mutation: Mutations::CreateOrUpdateFields
    field :create_or_update_action_model, mutation: Mutations::CreateOrUpdateActionModel
    field :create_or_update_action_models, mutation: Mutations::CreateOrUpdateActionModels
    field :create_or_update_action, mutation: Mutations::CreateOrUpdateAction
    field :create_or_update_actions, mutation: Mutations::CreateOrUpdateActions
    field :create_or_update_entity, mutation: Mutations::CreateOrUpdateEntity
    field :create_or_update_entities, mutation: Mutations::CreateOrUpdateEntities
    field :create_or_update_localizable, mutation: Mutations::CreateOrUpdateLocalizable
    field :create_or_update_enumeration_member, mutation: Mutations::CreateOrUpdateEnumerationMember
    field :create_or_update_enumeration_members, mutation: Mutations::CreateOrUpdateEnumerationMembers
    field :create_or_update_section, mutation: Mutations::CreateOrUpdateSection
    field :create_or_update_field_options, mutation: Mutations::CreateOrUpdateFieldOptions
    field :create_or_update_localizable, mutation: Mutations::CreateOrUpdateLocalizable
    field :create_or_update_localizables, mutation: Mutations::CreateOrUpdateLocalizables
  end
end
