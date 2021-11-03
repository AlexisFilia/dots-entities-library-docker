class Entity < ApplicationRecord
  belongs_to :parent, class_name: 'Entity', optional: true

  has_and_belongs_to_many :fields

  has_many :childs, class_name: 'Entity',
                    foreign_key: 'parent_id'
  has_many :agent_links
  has_many :target_links
  has_one :setting
end
