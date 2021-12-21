class ActionsEntity < ApplicationRecord
  belongs_to :action
  belongs_to :entity
end
