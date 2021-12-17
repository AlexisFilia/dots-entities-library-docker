module Types
  module Input
    class FieldtypeInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :type_of, Types::Enum::FieldtypeEnumType, required: false
    end
  end
end
