class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.references :field, null: false, foreign_key: true
      t.references :optionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
