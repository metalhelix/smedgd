class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :transcripts do |t|
      t.integer :location_id
      t.integer :gene_id
      t.text :sequence_aa
      t.text :sequence_nuc
      t.string :name

      t.timestamps
    end
  end
end
