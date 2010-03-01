class ContextualHelpGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      unless options[:no_migration]
        migration = "create_contextual_help_tables"
        m.migration_template "#{migration}.rb", 'db/migrate',
        :assigns => {:migration_name => migration },
        :migration_file_name => migration
      end
      # m.directory "lib"
      # m.template 'README', "README"
    end
  end
end
