class SectionElement < ApplicationRecord
  belongs_to :section
  belongs_to :sectionable, polymorphic: true

  validates :section_id, uniqueness: { scope: %i[sectionable_type sectionable_id],
                                       message: 'This element is already in the section' }
end
