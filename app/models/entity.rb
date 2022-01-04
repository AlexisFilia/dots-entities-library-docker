class Entity < ApplicationRecord
  has_ancestry

  has_many :sections, dependent: :destroy
  has_many :section_elements, through: :sections

  has_and_belongs_to_many :actions

  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true

  after_create :create_roots_section

  def elements
    section_elements.map(&:sectionable)
  end

  def create_roots_section
    s1 = Section.create!(name: 'fieldsRootSection', entity: self)
    s2 = Section.create!(name: 'actionsRootSection', entity: self, element_type: 'action')
    update(child_order: "[#{s1.id},#{s2.id}]")
  end

  def child_order
    JSON.parse(super)
  end

  def default_fields
    JSON.parse(super)
  end

  def default_actions
    JSON.parse(super)
  end

  def target_of
    actions
  end
end
