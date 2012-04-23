require 'rails/generators'

module SqlPager
  module Generators
    class SqlPagerGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      
      check_class_collision :suffix => "Controller"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def create_controller
        template "controller.rb", File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end
      
      def add_route
        route "get '(*view_path)' => '#{plural_name}#show'"
      end
      
      hook_for :orm
      
    end
  end
end