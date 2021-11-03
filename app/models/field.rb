class Field < ApplicationRecord
  has_and_belongs_to_many :entities

  has_many :option_types, as: :optionable
  has_many :options, through: :option_types
  has_many :enumeration_members, through: :options
end
