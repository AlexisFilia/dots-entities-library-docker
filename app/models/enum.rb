class Enum < ApplicationRecord
  has_many :enumeration_members, dependent: :destroy

  has_many :field_options, as: :option, dependent: :destroy
  has_many :fields, through: :field_options

  has_many :localizables, as: :localizable, dependent: :destroy
end
