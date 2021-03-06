ActionController::Base.send(:include, ContextualHelpController)
ActionView::Base.send(:include, ContextualHelpHelper)

# puts <<-eos


#   To complete setup, you'll need to run:
#     rake db:migrate

#   Also, add the following to config/routes. These will hook-up Contextual Help for you.
  
#   # Standard REST for the Articles and location
#   map.resources :help_articles
#   map.resources :help_locations

#   # These allow anything/help to get picked up on by Contextual Help     
#   map.connect ':controller/help', :action => :help
#   map.connect ':controller/:rest/help', :action => :help

#   Finally, add this to ApplicationController
#   contextual_help

# eos
