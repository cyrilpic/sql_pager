require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Capybara::DSL
  
  tests PagesController
  
  setup do
    page = Page.create!({
      body: '<h1><%= "Hello world from ruby !" %></h1>',
      path: 'posts/index',
      handler: 'erb',
      format: 'html',
      locale: 'en'
    })
  end
  
  test "PagesController responds to with_sql_resolver" do
    assert PagesController.respond_to? :with_sql_resolver
  end
  
  test "PagesController displays the correct page retrieved from the database" do
    visit '/posts/index'
    assert_match "<h1>Hello world from ruby !</h1>", page.body
  end
end
