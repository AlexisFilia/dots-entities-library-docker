class Field < ApplicationRecord
  has_many :section_elements, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy
  has_many :composants, dependent: :destroy

  has_and_belongs_to_many :fieldtypes

  has_many :enumeration_members, through: :fieldtypes

  validates :name, uniqueness: true
end
