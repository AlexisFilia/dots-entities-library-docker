class Fieldtype < ApplicationRecord
  has_and_belongs_to_many :fields

  has_many :enumeration_members
  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true
end
