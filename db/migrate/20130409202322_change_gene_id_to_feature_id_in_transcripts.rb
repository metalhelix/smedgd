class ChangeGeneIdToFeatureIdInTranscripts < ActiveRecord::Migration
  def change
    rename_column :transcripts, :gene_id, :feature_id
  end
end
