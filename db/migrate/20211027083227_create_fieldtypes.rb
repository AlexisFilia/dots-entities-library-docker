class CreateFieldtypes < ActiveRecord::Migration[6.1]
  def change
    create_table :fieldtypes do |t|
      t.string :name
      t.string :type_of

      t.timestamps
    end
  end
end
