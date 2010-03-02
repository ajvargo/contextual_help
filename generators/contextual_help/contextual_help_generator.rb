class ContextualHelpGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      unless options[:no_migration]
        migration = "create_contextual_help_tables"
        m.migration_template "db/#{migration}.rb", 'db/migrate',
        :assigns => {:migration_name => migration },
        :migration_file_name => migration
      end
  
      unless options[:no_views]
        m.directory "app/views/help_locations"
        %W[index edit new show].each do |view|
          m.file  "app/views/help_locations/#{view}.html.erb", "app/views/help_locations/#{view}.html.erb"
        end
        
        m.directory "app/views/help_articles"

        m.directory "app/views/shared"
        
      end
      # m.directory "lib"
      # m.template 'README', "README"
    end
  end
end
