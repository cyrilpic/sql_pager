require 'rails/generators'

module SqlPager
  module Generators
    class SqlPagerGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      
      class_option :page_info, type: :boolean, require: false, default: false
      class_option :activeadmin, type: :boolean, require: :false, default: false
      
      check_class_collision :suffix => "Controller"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def create_controller
        template "controller.rb", File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end
      
      def add_route
        route "get '(*view_path)' => '#{plural_name}#show', as: :#{singular_name}"
      end
      
      def copy_activeadmin_file
        template "activeadmin.rb", File.join('app/admin', class_path, "#{singular_name}.rb") if options.activeadmin?
      end
      
      hook_for :orm
      
    end
  end
end