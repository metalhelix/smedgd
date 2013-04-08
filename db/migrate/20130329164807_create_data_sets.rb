class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|
      t.string :name
      t.string :version
      t.string :url
      t.string :type
      t.string :organism

      t.timestamps
    end
  end
end
