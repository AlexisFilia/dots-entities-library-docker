class ActionModel < ApplicationRecord
  has_many :agent_links, dependent: :destroy
  has_many :agents, through: :agent_links, source: :entity
  has_many :target_links, dependent: :destroy
  has_many :targets, through: :target_links, source: :entity
  has_many :actions, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
