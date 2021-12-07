class Section < ApplicationRecord
  belongs_to :entity
  has_many :section_elements, dependent: :destroy

  def elements
    section_elements.map(&:sectionable)
  end

  def order
    JSON.parse(super)
  end
end
