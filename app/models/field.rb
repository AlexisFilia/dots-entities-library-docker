class Field < ApplicationRecord
  has_and_belongs_to_many :entities

  has_many :field_options
  has_many :datatypes, through: :field_options, source: :option, source_type: 'Datatype'
  has_many :enums, through: :field_options, source: :option, source_type: 'Enum'
  has_many :enumeration_members, through: :enums

  def options
    field_options.map(&:option)
  end
end
