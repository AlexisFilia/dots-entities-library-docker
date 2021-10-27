class Action < ApplicationRecord
  has_many :agent_links
  has_many :target_links
end
