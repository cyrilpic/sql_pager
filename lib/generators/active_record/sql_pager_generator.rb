require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class SqlPagerGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      
      def copy_migration
        migration_template "migration.rb", "db/migrate/sql_pager_create_#{table_name}"
      end
      
      def create_model
        invoke 'active_record:model', [name], :migration => false
      end
      
      def inject_model_content
        inject_into_class model_path, class_name, model_data if model_exists?
      end
      
      # Helpers
      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end
      
      def model_data
<<CONTENT
  # Attributes
  attr_accessible :body, :format, :handler, :path, :partial, :locale
    
  # Validation
  validates :body, :presence => true
  validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
  validates :format, :inclusion => Mime::SET.symbols.map(&:to_s)
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s)
  validates :path, :presence => true
    
  after_save do
    SqlPager::Resolver.instance(self.class.model_name.underscore).clear_cache
  end
CONTENT
      end
    end
  end
end