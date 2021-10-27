class Field < ApplicationRecord
  has_and_belongs_to_many :datatypes
  has_and_belongs_to_many :enums
  has_and_belongs_to_many :entities
  has_many :enumeration_members, through: :enums
end
