class Entity < ApplicationRecord
  has_ancestry

  has_many :sections, dependent: :destroy

  has_many :agent_links, dependent: :destroy
  has_many :action_models, through: :agent_links
  has_many :target_links, dependent: :destroy
  has_many :target_of, through: :target_links, source: :action_model

  has_many :localizables, as: :localizable, dependent: :destroy

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
