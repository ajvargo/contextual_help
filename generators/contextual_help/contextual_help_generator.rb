class ContextualHelpGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      unless options[:skip_migration]
        migration = "create_contextual_help_tables"
        m.migration_template "db/#{migration}.rb", 'db/migrate', 
        :assigns => {:migration_name => migration }, :migration_file_name => migration        
      end
      
      unless options[:skip_views]
        m.directory "app/views/help_locations"
        %W[index edit new show].each do |view|
          m.file  "app/views/help_locations/#{view}.html.erb", "app/views/help_locations/#{view}.html.erb"
        end
        
        m.directory "app/views/help_articles"
        %W[index edit new show _form].each do |view|
          m.file  "app/views/help_articles/#{view}.html.erb", "app/views/help_articles/#{view}.html.erb"
        end

        m.directory "app/views/shared"
        m.file  "app/views/shared/help.html.erb", "app/views/shared/help.html.erb"
      end

      unless options[:skip_routes]
        m.route_resources "help_articles"
        m.route_resources "help_locations"
        # add generic help catches to config/routes.rb
        logger.route "map.connect  :controller/help, :action => :help"
        logger.route "map.connect :controller/:rest/help', :action => :help"
        look_for = 'ActionController::Routing::Routes.draw do |map|'
        m.gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  map.connect ':controller/:rest/help', :action => :help\n"}
        m.gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  map.connect ':controller/help', :action => :help\n"}
      end

      unless options[:skip_controller]
        logger.controller "adding 'contextual_help' to application controller"
        look_for = 'class ApplicationController < ActionController::Base'
        m.gsub_file('app/controllers/application_controller.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  contextual_help \n"}
      end
    end
  end
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--skip-migration",
           "Don't generate a migration file for help locations or articles") { |v| options[:skip_migration] = true }
    opt.on("--skip-views",
           "Don't generate a copy of the views") { |v| options[:skip_views] = true }
    opt.on("--skip-routes",
           "Don't add in contextual help releated routes") { |v| options[:skip_routes] = true }
    opt.on("--skip-controller",
           "Don't add 'contextual_help' mixin call to app/controllers/application_controller.rb") { |v| options[:skip_controller] = true }
 end
end
