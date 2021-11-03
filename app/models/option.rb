class Option < ApplicationRecord
  belongs_to :field
  belongs_to :optionable, polymorphic: true
end
