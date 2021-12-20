module Types
  class MutationType < Types::BaseObject
    field :create_or_update_fieldtype, mutation: Mutations::CreateOrUpdateFieldtype
    field :create_or_update_fieldtypes, mutation: Mutations::CreateOrUpdateFieldtypes
    field :create_or_update_field, mutation: Mutations::CreateOrUpdateField
    field :create_or_update_fields, mutation: Mutations::CreateOrUpdateFields
    field :create_or_update_action, mutation: Mutations::CreateOrUpdateAction
    field :create_or_update_actions, mutation: Mutations::CreateOrUpdateActions
    field :create_or_update_entity, mutation: Mutations::CreateOrUpdateEntity
    field :create_or_update_entities, mutation: Mutations::CreateOrUpdateEntities
    field :create_or_update_composant, mutation: Mutations::CreateOrUpdateComposant
    field :create_or_update_composants, mutation: Mutations::CreateOrUpdateComposants
    field :create_or_update_localizable, mutation: Mutations::CreateOrUpdateLocalizable
    field :create_or_update_enumeration_member, mutation: Mutations::CreateOrUpdateEnumerationMember
    field :create_or_update_enumeration_members, mutation: Mutations::CreateOrUpdateEnumerationMembers
    field :create_or_update_section, mutation: Mutations::CreateOrUpdateSection
    field :create_or_update_localizable, mutation: Mutations::CreateOrUpdateLocalizable
    field :create_or_update_localizables, mutation: Mutations::CreateOrUpdateLocalizables
    field :create_or_update_actions_entity, mutation: Mutations::CreateOrUpdateActionsEntity
    field :create_or_update_actions_entities, mutation: Mutations::CreateOrUpdateActionsEntities
    field :create_or_update_fields_fieldtypes, mutation: Mutations::CreateOrUpdateFieldsFieldtypes
    field :create_or_update_section_elements, mutation: Mutations::CreateOrUpdateSectionElements
  end
end
