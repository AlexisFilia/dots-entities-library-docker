class FieldModel < ApplicationRecord
  has_many :field_options, dependent: :destroy
  has_many :fields, dependent: :destroy
  has_many :localizables, as: :localizable, dependent: :destroy
end
