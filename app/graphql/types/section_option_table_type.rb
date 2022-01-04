class Types::SectionOptionTableType < Types::BaseUnion
  description "Option for section: 'field' or 'action'"

  possible_types Types::FieldType,
                 Types::ActionType

  def self.resolve_type(object, _context)
    if object.is_a?(Field)
      Types::FieldType
    elsif object.is_a?(Action)
      Types::ActionType
    end
  end
end
