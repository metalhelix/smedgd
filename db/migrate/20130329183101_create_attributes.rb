class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :type
      t.string :name
      t.float :value
      t.string :source_id

      t.timestamps
    end
  end
end
