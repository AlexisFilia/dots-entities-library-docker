class Localizable < ApplicationRecord
  belongs_to :localizable, polymorphic: true

  validates :type_of, uniqueness: { scope: %i[localizable_type localizable_id language],
                                    message: 'This localizable already exists' }

  def localizable_type
    super.downcase_first
  end
end
