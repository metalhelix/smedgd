class AddSlugIndexToGenes < ActiveRecord::Migration
  def change
    add_index :genes, :slug, unique: true
  end
end
