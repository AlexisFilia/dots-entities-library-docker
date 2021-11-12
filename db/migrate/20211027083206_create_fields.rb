class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.boolean :is_default, default: true
      t.references :field_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
