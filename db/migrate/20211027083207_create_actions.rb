class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.boolean :is_default
      t.references :action_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
