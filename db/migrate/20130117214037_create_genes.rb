class CreateGenes < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.string :name
      t.string :type
      t.integer :location_id
      t.string :link
      t.integer :genome_id
      t.string :slug
      t.string :standard_id

      t.timestamps
    end
  end
end
