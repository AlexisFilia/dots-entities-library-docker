class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :labels
      t.string :descriptions
      t.references :parent, foreign_key: { to_table: :entities }

      t.timestamps
    end
  end
end
