class SwitchFeaturesSlug < ActiveRecord::Migration
  def change
    remove_index :features, :name => :index_genes_on_slug
    add_index :features, :slug, unique: true
  end
end
