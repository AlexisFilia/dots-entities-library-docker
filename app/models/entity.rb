class Entity < ApplicationRecord
  has_ancestry

  has_many :sections, dependent: :destroy

  has_many :agent_links, dependent: :destroy
  has_many :action_models, through: :agent_links
  has_many :target_links, dependent: :destroy
  has_many :target_of, through: :target_links, source: :action_model

  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true

  after_create :create_roots_section

  def create_roots_section
    s1 = Section.create!(name: 'fieldsRootSection', entity: self)
    s2 = Section.create!(name: 'actionsRootSection', entity: self, element_type: 'Action')
    update(order: "[#{s1.id},#{s2.id}]")
  end

  def labels(arg)
    labels = localizables.where(type_of: 'label')
    labels = labels.where(language: arg[:language_is]) if arg[:language_is]
    labels
  end

  def descriptions(arg)
    descriptions = localizables.where(type_of: 'description')
    descriptions = descriptions.where(language: arg[:language_is]) if arg[:language_is]
    descriptions
  end
end
