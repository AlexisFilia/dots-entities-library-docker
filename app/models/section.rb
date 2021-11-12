class Section < ApplicationRecord
  belongs_to :entity
  has_many :section_elements, dependent: :destroy

  def type_of
    section_elements.first.sectionable_type
  end

  def elements
    section_elements.map(&:sectionable)
  end
end