class SwitchReservedKeyWord < ActiveRecord::Migration
  def change
    rename_column :genomes, :key, :unique_name
  end
end
