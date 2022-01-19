class CreateLocalizables < ActiveRecord::Migration[6.1]
  def change
    create_table :localizables do |t|
      t.string :type_of
      t.string :language
      t.string :value
      t.string :summary
      t.references :localizable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
