class CreateTargetLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :target_links do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :action_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
