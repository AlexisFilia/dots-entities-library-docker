class CreateAction < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :inverse
      t.string :main

      t.timestamps
    end
  end
end
