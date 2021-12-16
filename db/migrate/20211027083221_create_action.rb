class CreateAction < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :inverse
      t.string :main

      t.timestamps
    end
  end
end
