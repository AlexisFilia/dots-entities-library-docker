class Datatype < ApplicationRecord
  has_many :field_options, as: :optionable
  has_many :fields, through: :field_options
  has_many :localizables, as: :localizable, dependent: :destroy

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
