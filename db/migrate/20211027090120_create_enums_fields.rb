class CreateEnumsFields < ActiveRecord::Migration[6.1]
  def change
    create_table :enums_fields do |t|
      t.references :enum, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
