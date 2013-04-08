class AddGeneIdToAttributes < ActiveRecord::Migration
  def change
    add_column :attributes, :gene_id, :integer
  end
end
