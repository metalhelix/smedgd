class Gene < ActiveRecord::Base
  extend FriendlyId
  friendly_id :standard_id, use: :slugged

  belongs_to :genome
  has_one :location
  has_many :transcripts

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :transcripts

  attr_accessible :link, :name, :standard_id, :type

  def self.search(search, type)
    if search
      case type
      when 'name'
        self.search_name(search)
      when 'go'
        self.search_go(search)
      when 'homology'
        self.search_homology(search)
      else
        find(:all)
      end
    else
      find(:all)
    end
  end

  def self.search_name(name)
    where("name LIKE ?", "%#{name}%")
  end

  def self.search_go(go_term)
    where("name LIKE ?", "%#{go_term}%")
  end

  def self.search_homology(homology_term)
    where("name LIKE ?", "%#{homology_term}%")
  end

end