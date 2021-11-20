class Field < ApplicationRecord
  belongs_to :field_model

  has_many :localizables, as: :localizable, dependent: :destroy
  has_one :section_element, as: :sectionable, dependent: :destroy
  has_one :section, through: :section_element

  def options
    field_options.map(&:option)
  end

  def name
    field_model.name
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
