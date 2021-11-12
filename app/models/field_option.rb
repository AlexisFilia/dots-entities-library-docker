class FieldOption < ApplicationRecord
  belongs_to :field_model
  belongs_to :optionable, polymorphic: true

  validates :field_model_id, uniqueness: { scope: %i[optionable_type optionable_id],
                                           message: 'This element is already in the field model' }
end
