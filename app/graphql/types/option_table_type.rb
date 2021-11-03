class Types::OptionTableType < Types::BaseUnion
  description 'Option for field: '

  possible_types Types::DatatypeType,
                 Types::EnumType

  def self.resolve_type(object, _context)
    if object.is_a?(Datatype)
      Types::DatatypeType
    elsif object.is_a?(Enum)
      Types::EnumType
    end
  end
end
