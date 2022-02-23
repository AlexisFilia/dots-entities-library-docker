class CreateLocalizables < ActiveRecord::Migration[6.1]
  def change
    create_table :localizables do |t|
      t.string :type_of
      t.string :language
      t.string :value
      t.references :localizable, polymorphic: true, null: false

      t.timestamps
    end
    add_index(:localizables, %i[localizable_id localizable_type type_of language], unique: true, name: 'index')
  end
end
