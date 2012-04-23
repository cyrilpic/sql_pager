require 'test_helper'

class ResolverTest < ActiveSupport::TestCase
  
  test "resolver returns a template with the saved body" do
    resolver = SqlPager::Resolver.instance :page
    details_1 = { formats: [:html], locale: [:fr], handlers: [:erb] }
    details_2 = { formats: [:html], locale: [:en], handlers: [:erb] }
      
    assert resolver.find_all('index', 'posts', false, details_1).empty?
    
    Page.create!(
      body: "<h1>You are at <%= 'posts/index' %></h1>",
      path: 'posts/index',
      format: 'html',
      locale: 'en',
      handler: 'erb',
      partial: false
    )
    
    assert resolver.find_all('index', 'posts', false, details_1).empty?
    template = resolver.find_all('index', 'posts', false, details_2).first
    assert_kind_of ActionView::Template, template
      
    assert_equal "<h1>You are at <%= 'posts/index' %></h1>", template.source
    assert_equal [:html], template.formats
    assert_equal 'posts/index', template.virtual_path
  end
  
end