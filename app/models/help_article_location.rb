class HelpArticleLocation < ActiveRecord::Base
  belongs_to :help_article
  belongs_to :help_location
end
