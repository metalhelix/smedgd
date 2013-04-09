class SwitchReservedWords < ActiveRecord::Migration
  def change
    rename_column :features, :type, :category
    rename_column :features, :standard_id, :standard_name
    rename_column :annotations, :type, :category
    rename_column :attributes, :type, :category
    rename_column :data_sets, :type, :category
  end
end
