class Action < ApplicationRecord
  belongs_to :action_model
  has_many :localizables, as: :localizable, dependent: :destroy
  has_many :sectionables, as: :sectionable, dependent: :destroy
end
