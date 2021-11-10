class CreateFieldModels < ActiveRecord::Migration[6.1]
  def change
    create_table :field_models do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
