class CreateEnums < ActiveRecord::Migration[6.1]
  def change
    create_table :enums do |t|
      t.string :name
      t.string :labels
      t.string :descriptions

      t.timestamps
    end
  end
end
