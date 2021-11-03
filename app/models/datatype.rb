class Datatype < ApplicationRecord
  has_many :used_in_fields, as: :optionable
  has_many :fields, through: :used_in_fields
end
