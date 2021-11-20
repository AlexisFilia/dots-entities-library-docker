class Enum < ApplicationRecord
  has_many :enumeration_members, dependent: :destroy

  has_many :field_options, as: :optionable, dependent: :destroy
  has_many :field_models, through: :field_options

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
