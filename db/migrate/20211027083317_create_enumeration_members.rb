class CreateEnumerationMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :enumeration_members do |t|
      t.string :name, null: false, index: { unique: true }
      t.references :fieldtype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
