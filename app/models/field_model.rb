class FieldModel < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy

  has_many :field_options, dependent: :destroy
  has_many :datatypes, through: :field_options, source: :option, source_type: 'Datatype'
  has_many :enums, through: :field_options, source: :option, source_type: 'Enum'
  has_many :enumeration_members, through: :enums

  validates :name, uniqueness: true

  def options
    field_options.map(&:optionable)
  end

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
