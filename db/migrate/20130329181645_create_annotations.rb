class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :gene_id
      t.string :type
      t.float :score
      t.string :value
      t.text :description
      t.integer :source_id

      t.timestamps
    end
  end
end
