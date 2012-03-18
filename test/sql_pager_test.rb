require 'test_helper'

class SqlPagerTest < ActiveSupport::TestCase
  
  test "SqlPager is a module" do
    assert_kind_of Module, SqlPager
  end
  
  test "SqlPager exposes a config API" do
    variables = ['model_name']
    
    variables.each do |v|
      # default values
      assert_not_nil SqlPager.send(v), "#{v} should not be null by default"
      # direct API
      SqlPager.send("#{v}=","test_class")
      assert_equal "test_class", SqlPager.send(v), "#{v} should now be equal to test_class"
      # config API
      SqlPager.setup do |config|
        config.send("#{v}=","test_class2")
      end
      assert_equal "test_class2", SqlPager.send(v), "#{v} should now be equal to test_class2"
    end
    
  end
  
  test "SqlPager adds a config namespace to rails" do
    assert_equal Rails.application.config.sql_pager, SqlPager
  end
  
end
