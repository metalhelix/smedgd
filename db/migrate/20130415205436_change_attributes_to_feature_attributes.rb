class ChangeAttributesToFeatureAttributes < ActiveRecord::Migration
  def change
    rename_table :attributes, :feature_attributes
  end
end
