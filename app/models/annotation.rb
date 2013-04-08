class Annotation < ActiveRecord::Base
  attr_accessible :description, :score, :type, :value

  belongs_to :feature
  belongs_to :data_set, :class_name => "DataSet", :foreign_key => "source_id"
end
