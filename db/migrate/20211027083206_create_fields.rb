class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :labels
      t.string :descriptions

      t.timestamps
    end
  end
end
