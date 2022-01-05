class Action < ApplicationRecord
  has_and_belongs_to_many :entities
  has_many :section_elements, as: :sectionable, dependent: :destroy
  has_many :sections, through: :section_elements
  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true
end
