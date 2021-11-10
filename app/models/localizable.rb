class Localizable < ApplicationRecord
  belongs_to :localizable, polymorphic: true
end
