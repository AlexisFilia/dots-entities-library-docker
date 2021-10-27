class CreateDatatypes < ActiveRecord::Migration[6.1]
  def change
    create_table :datatypes do |t|
      t.string :name
      t.string :labels
      t.string :descriptions

      t.timestamps
    end
  end
end
