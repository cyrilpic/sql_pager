# SqlPager initializer
SqlPager.setup do |config|
  # Set the name of the page model
  config.model_name = :<%= class_name.underscore %>
end