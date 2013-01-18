class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :sequence_name
      t.string :sequence_type
      t.integer :start
      t.integer :stop
      t.integer :strand

      t.timestamps
    end
  end
end
