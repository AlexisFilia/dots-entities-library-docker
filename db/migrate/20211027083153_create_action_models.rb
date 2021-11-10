class CreateActionModels < ActiveRecord::Migration[6.1]
  def change
    create_table :action_models do |t|
      t.string :name
      t.string :inverse
      t.string :main

      t.timestamps
    end
  end
end
