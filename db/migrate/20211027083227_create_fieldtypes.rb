class CreateFieldtypes < ActiveRecord::Migration[6.1]
  def change
    create_table :fieldtypes do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :type_of

      t.timestamps
    end
  end
end
