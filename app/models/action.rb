class Action < ApplicationRecord
  belongs_to :action_model

  has_many :localizables, as: :localizable, dependent: :destroy
  has_one :section_element, as: :sectionable, dependent: :destroy
  has_one :section, through: :section_element

  def name
    action_model.name
  end

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
