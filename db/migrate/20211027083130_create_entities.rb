class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :order, default: '[]'
      t.string :default_fields, default: '[]'
      t.string :default_actions, default: '[]'

      t.timestamps
    end
  end
end
