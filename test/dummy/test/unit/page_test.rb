require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  test "Page is a valid record" do
    assert !Page.new.valid?, "Empty page should not be valid."
      
    page = Page.new body: '<h1>Hello Wolrd <%= "from ruby" ?></h1>'
    assert !page.valid?
    page.assign_attributes handler: 'erb'
    assert !page.valid?
    page.assign_attributes format: 'html'
    assert !page.valid?
    page.assign_attributes locale: 'en'
    assert !page.valid?
    page.assign_attributes path: 'posts/index'
    assert page.valid?
    assert !page.partial
      
    assert_equal 'html', page.format
    assert_equal 'en', page.locale
    assert_equal 'posts/index', page.path
    assert_equal '<h1>Hello Wolrd <%= "from ruby" ?></h1>', page.body
  end
  
end
