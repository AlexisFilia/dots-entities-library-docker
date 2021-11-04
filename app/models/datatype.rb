class Datatype < ApplicationRecord
  has_many :field_options, as: :option
  has_many :fields, through: :field_options
end
