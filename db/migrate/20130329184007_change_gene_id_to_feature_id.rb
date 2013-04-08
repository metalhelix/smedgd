class ChangeGeneIdToFeatureId < ActiveRecord::Migration
  def change
    rename_column :attributes, :gene_id, :feature_id
    rename_column :annotations, :gene_id, :feature_id

  end
end
