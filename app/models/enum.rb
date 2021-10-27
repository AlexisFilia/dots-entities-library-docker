class Enum < ApplicationRecord
  has_many :enumeration_members
  has_and_belongs_to_many :fields
end
