class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :child_order, default: '[]'
      t.string :default_fields, default: '[]'
      t.string :default_actions, default: '[]'

      t.timestamps
    end
  end
end
