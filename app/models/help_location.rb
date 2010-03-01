class HelpLocation < ActiveRecord::Base
  has_many :help_article_locations  
  has_many :help_articles, :through => :help_article_locations
end
