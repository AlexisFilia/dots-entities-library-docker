class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :labels
      t.string :descriptions
      t.string :inverse
      t.string :main

      t.timestamps
    end
  end
end
