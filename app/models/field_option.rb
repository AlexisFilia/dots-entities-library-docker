class FieldOption < ApplicationRecord
  belongs_to :field
  belongs_to :option, polymorphic: true
end
