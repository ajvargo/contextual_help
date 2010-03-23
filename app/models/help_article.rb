class HelpArticle < ActiveRecord::Base
  has_many :help_article_locations  
  has_many :help_locations, :through => :help_article_locations 

  named_scope :in_use, lambda{|controller, action| { :include => :help_locations, :conditions => ['help_locations.controller = ? AND help_locations.action = ? AND help_articles.in_use = ?', controller, action, true] }}
  named_scope :page_tips, :conditions => ['page_tip = ?' , true]
end
