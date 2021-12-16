class CreateActionsEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :actions_entities do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
