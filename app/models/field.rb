class Field < ApplicationRecord
  belongs_to :field_model

  has_many :localizables, as: :localizable, dependent: :destroy
  has_many :sectionables, as: :sectionable, dependent: :destroy

  def options
    field_options.map(&:option)
  end
end
