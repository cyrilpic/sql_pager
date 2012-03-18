class Page < ActiveRecord::Base
  # Attributes
  attr_accessible :body, :format, :handler, :path, :partial, :locale
    
  # Validation
  validates :body, :presence => true
  validates :handler, :inclusion => ActionView::Template::Handlers.extensions.map(&:to_s)
  validates :format, :inclusion => Mime::SET.symbols.map(&:to_s)
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s)
  validates :path, :presence => true
    
  after_save do
    SqlPager::Resolver.instance.clear_cache
  end
  
end
