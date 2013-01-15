class AddKeyToGenomes < ActiveRecord::Migration
  def change
    add_column :genomes, :key, :string
  end
end
