class CreateContextualHelpTables < ActiveRecord::Migration
  def self.up
    create_table :help_locations do |t|
      t.string :controller
      t.string :action
      t.boolean :in_use, :default => true
      
      t.timestamps
    end

    create_table :help_articles do |t|
      t.string :title
      t.text :body
      t.boolean :in_use, :default => true
      t.integer :position
      t.boolean :page_tip, :default => false
      t.timestamps
    end

    create_table :help_article_locations, :id => false do |t|
      t.column "help_article_id", :integer
      t.column "help_location_id", :integer      
    end

    add_index "help_article_locations", "help_article_id"
    add_index "help_article_locations", "help_location_id"
  end
    
  def self.down
    drop_table :help_locations
    drop_table :help_articles
    drop_table :help_article_locations
  end
end
