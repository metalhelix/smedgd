class Location < ActiveRecord::Base
  attr_accessible :sequence_name, :sequence_type, :start, :stop, :strand
end
