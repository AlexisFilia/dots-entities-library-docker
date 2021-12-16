class CreateFieldsFieldtypes < ActiveRecord::Migration[6.1]
  def change
    create_table :fields_fieldtypes do |t|
      t.references :field, null: false, foreign_key: true
      t.references :fieldtype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
