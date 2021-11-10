class EnumerationMember < ApplicationRecord
  belongs_to :enum

  has_many :localizables, as: :localizable, dependent: :destroy
end
