class Attribute < ActiveRecord::Base
  attr_accessible :name, :type, :value

  belongs_to :data_set, :class_name => "DataSet", :foreign_key => "source_id"
  belongs_to :feature
end
