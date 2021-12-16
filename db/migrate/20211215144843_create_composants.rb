class CreateComposants < ActiveRecord::Migration[6.1]
  def change
    create_table :composants do |t|
      t.string :code
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
