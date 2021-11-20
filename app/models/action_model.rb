class ActionModel < ApplicationRecord
  has_many :target_links, dependent: :destroy
  has_many :targets, through: :target_links, source: :entity
  has_many :actions, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true

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
