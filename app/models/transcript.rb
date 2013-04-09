class Transcript < ActiveRecord::Base
  belongs_to :feature
  has_one :location

  accepts_nested_attributes_for :location

  attr_accessible :name, :sequence_aa, :sequence_nuc
end
