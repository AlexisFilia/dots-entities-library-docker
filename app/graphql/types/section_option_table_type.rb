class Types::SectionOptionTableType < Types::BaseUnion
  description 'Option for section: Field or Action'

  possible_types Types::FieldType,
                 Types::ActionType

  def self.resolve_type(object, _context)
    if object.is_a?(Fieldtype)
      Types::FieldtypeType
    elsif object.is_a?(Action)
      Types::ActionType
    end
  end
end
