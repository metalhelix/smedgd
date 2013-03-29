class SwitchGenesToFeatures < ActiveRecord::Migration
  def change
    rename_table :genes, :features
  end
end
