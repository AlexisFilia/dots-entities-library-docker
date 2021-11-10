class Section < ApplicationRecord
  belongs_to :entity
  has_many :section_elements, dependent: :destroy
end
