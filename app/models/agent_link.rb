class AgentLink < ApplicationRecord
  belongs_to :entity
  belongs_to :action_model
end
