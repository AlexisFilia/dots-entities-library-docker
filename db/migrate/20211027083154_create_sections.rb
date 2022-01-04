class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.string :child_order, default: '[]'
      t.string :element_type, default: 'field'
      t.references :entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
