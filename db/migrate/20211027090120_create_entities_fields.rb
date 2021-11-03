class CreateEntitiesFields < ActiveRecord::Migration[6.1]
  def change
    create_table :entities_fields do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
