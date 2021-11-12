class CreateFieldOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :field_options do |t|
      t.references :field_model, null: false, foreign_key: true
      t.references :optionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
