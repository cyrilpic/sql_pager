module SqlPager
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)
    desc "This generator creates an initializer file at config/initializers"
    def create_initializer_file
      template "sql_pager.rb", "config/initializers/sql_pager.rb"
    end
  end
end