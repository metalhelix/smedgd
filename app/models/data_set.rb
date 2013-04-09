class DataSet < ActiveRecord::Base
  attr_accessible :name, :organism, :category, :url, :version
  has_many :annotations
end
