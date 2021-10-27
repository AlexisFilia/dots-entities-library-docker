class CreateDatatypesFields < ActiveRecord::Migration[6.1]
  def change
    create_table :datatypes_fields do |t|
      t.references :datatype, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
