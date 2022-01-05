class Field < ApplicationRecord
  has_many :section_elements, as: :sectionable, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy
  has_many :composants, dependent: :destroy

  has_and_belongs_to_many :fieldtypes

  has_many :enumeration_members, through: :fieldtypes
  has_many :sections, through: :section_elements

  validates :name, uniqueness: true
end
