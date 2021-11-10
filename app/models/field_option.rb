class FieldOption < ApplicationRecord
  belongs_to :field_model
  belongs_to :option, polymorphic: true
end
