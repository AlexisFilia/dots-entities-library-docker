class Types::LocalizableTableType < Types::BaseUnion
  description 'Option for section: Field or Action'

  possible_types Types::EntityType,
                 Types::ActionType,
                 Types::FieldType,
                 Types::FieldtypeType,
                 Types::EnumerationMemberType

  def self.resolve_type(object, _context)
    if object.is_a?(Entity)
      Types::EntityType
    elsif object.is_a?(Action)
      Types::ActionType
    elsif object.is_a?(Field)
      Types::FieldType
    elsif object.is_a?(Fieldtype)
      Types::FieldtypeType
    elsif object.is_a?(EnumerationMember)
      Types::EnumerationMemberType
    end
  end
end
