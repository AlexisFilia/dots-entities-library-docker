class Action < ApplicationRecord
  has_and_belongs_to_many :entities
  has_many :section_elements, dependent: :destroy
  has_many :section, through: :section_elements
  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true
end
