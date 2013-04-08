class DataSet < ActiveRecord::Base
  attr_accessible :name, :organism, :type, :url, :version
  has_many :annotations
end
