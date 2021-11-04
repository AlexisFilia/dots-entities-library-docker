class Entity < ApplicationRecord
  has_ancestry

  has_and_belongs_to_many :fields

  has_many :agent_links
  has_many :actions, through: :agent_links
  has_many :target_links
  has_many :target_of, through: :target_links, source: :entity
  has_one :setting
end
