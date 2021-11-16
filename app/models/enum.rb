class Enum < ApplicationRecord
  has_many :enumeration_members, dependent: :destroy

  has_many :field_options, as: :optionable, dependent: :destroy
  has_many :field_models, through: :field_options

  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
