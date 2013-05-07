class Annotation < ActiveRecord::Base
  attr_accessible :description, :score, :category, :value

  belongs_to :feature
  belongs_to :data_set, :class_name => "DataSet", :foreign_key => "source_id"

  def self.search(search, type)
    if search
      case type
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

  def self.search_go(go_term)
    self.includes(:feature).where("category = 'go_term' AND description LIKE ?", "%#{go_term}%")
  end

  def self.search_homology(term)
    self.includes(:feature).where("category = 'protein_homology' AND description LIKE ?", "%#{term}%")
  end
end
