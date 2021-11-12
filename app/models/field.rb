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

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
