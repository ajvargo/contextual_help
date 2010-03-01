class HelpArticle < ActiveRecord::Base
  has_many :help_article_locations  
  has_many :help_locations, :through => :help_article_locations 
  
  def self.help_article_count(controller, action)
    HelpLocation.find_all_by_action_and_controller("index", "comments").inject(0){|c,hl| c += hl.help_articles.count}
  end
end
