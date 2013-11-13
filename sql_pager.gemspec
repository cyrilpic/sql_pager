$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sql_pager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sql_pager"
  s.version     = SqlPager::VERSION
  s.authors     = ["Cyril Picard"]
  s.email       = ["cyril@picard.ch"]
  s.homepage    = "https://github.com/cyrilpic/sql_pager"
  s.summary     = "SqlPager adds an sql ActionView Resolver"
  s.description = "Description of SqlPager."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara"
  s.add_development_dependency "turn"
  s.add_development_dependency "minitest"
end
