class SectionElement < ApplicationRecord
  belongs_to :section
  belongs_to :sectionable, polymorphic: true
end
