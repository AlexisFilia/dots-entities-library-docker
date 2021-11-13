class EnumerationMember < ApplicationRecord
  belongs_to :enum

  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true

  def labels
    localizables.where(type_of: 'label')
  end

  def descriptions
    localizables.where(type_of: 'description')
  end
end
