class CreateEnums < ActiveRecord::Migration[6.1]
  def change
    create_table :enums do |t|
      t.string :name

      t.timestamps
    end
  end
end
