class AddSlugToGenomes < ActiveRecord::Migration
  def change
    add_column :genomes, :slug, :string
    add_index :genomes, :slug, unique: true
  end
end
