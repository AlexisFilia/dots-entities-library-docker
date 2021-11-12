class Types::LocalizableTableType < Types::BaseUnion
  description 'Option for section: Field or Action'

  possible_types Types::EntityType,
                 Types::ActionModelType,
                 Types::ActionType,
                 Types::FieldModelType,
                 Types::FieldType,
                 Types::DatatypeType,
                 Types::EnumType

  def self.resolve_type(object, _context)
    if object.is_a?(Entity)
      Types::EntityType
    elsif object.is_a?(ActionModel)
      Types::ActionModelType
    elsif object.is_a?(Action)
      Types::ActionType
    elsif object.is_a?(FieldModel)
      Types::FieldModelType
    elsif object.is_a?(Field)
      Types::FieldType
    elsif object.is_a?(Datatype)
      Types::DatatypeType
    elsif object.is_a?(Enum)
      Types::EnumType
    elsif object.is_a?(EnumerationMember)
      Types::EnumerationMemberType
    end
  end
end
