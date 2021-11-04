class Action < ApplicationRecord
  has_many :agent_links
  has_many :agents, through: :agent_links, source: :entity
  has_many :target_links
  has_many :targets, through: :target_links, source: :entity
end
