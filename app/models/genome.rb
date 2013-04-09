class Genome < ActiveRecord::Base
  extend FriendlyId
  friendly_id :unique_name, use: :slugged

  has_many :features

  attr_accessible :organism, :version, :unique_name

  validates_presence_of :organism, :version

  # before_save :set_name

  def set_name
    self.unique_name = self.organism.gsub(".","_") + "_" + self.version.gsub(".","_")
  end
end
