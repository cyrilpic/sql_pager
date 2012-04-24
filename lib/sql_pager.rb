require 'rails'

module SqlPager
  autoload :Resolver, 'sql_pager/resolver'
  autoload :ControllerHelper, 'sql_pager/controller_helper'
  
  mattr_accessor :model_name
  @@model_name = :page
  
  mattr_accessor :filter_column
  @@filter_column = :keyword
  
  # Config API
  def self.setup
    yield self
  end
  
end

ActionController::Base.send(:include, SqlPager::ControllerHelper)
ActionMailer::Base.send(:include, SqlPager::ControllerHelper)

require 'sql_pager/railtie'


