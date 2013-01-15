class CreateGenomes < ActiveRecord::Migration
  def change
    create_table :genomes do |t|
      t.string :organism
      t.string :version

      t.timestamps
    end
  end
end
