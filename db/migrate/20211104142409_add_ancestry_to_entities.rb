class AddAncestryToEntities < ActiveRecord::Migration[6.1]
  def change
    add_column :entities, :ancestry, :string
    add_index :entities, :ancestry
  end
end
