class CreateEnumerationMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :enumeration_members do |t|
      t.string :name
      t.references :enum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
