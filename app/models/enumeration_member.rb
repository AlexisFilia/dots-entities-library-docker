class EnumerationMember < ApplicationRecord
  belongs_to :fieldtype

  has_many :localizables, as: :localizable, dependent: :destroy

  validates :name, uniqueness: true
end
