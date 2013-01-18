class Genome < ActiveRecord::Base
  extend FriendlyId
  friendly_id :key, use: :slugged

  has_many :genes

  attr_accessible :organism, :version, :key

  validates_presence_of :organism, :version

  before_save :create_key

  def create_key
    self.key = self.organism.gsub(".","_") + "_" + self.version.gsub(".","_")
  end
end
