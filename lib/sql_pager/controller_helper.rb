module SqlPager
  module ControllerHelper
    module ClassMethods
      def with_sql_resolver(*args)
        append_view_path Resolver.instance *args
      end
    end
    
    def self.included(receiver)
      receiver.extend ClassMethods
    end
  end
end