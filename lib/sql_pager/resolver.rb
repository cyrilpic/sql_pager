module SqlPager
  class Resolver < ActionView::Resolver
    
    include Singleton
    
    protected
    def find_templates(name, prefix, partial, details)
      locals = normalize_array(details[:locale])
      formats = normalize_array(details[:formats])
      conditions = {
        path: normalize_path(name, prefix),
        handler: normalize_array(details[:handlers]),
        format: formats,
        locale: locals,
        partial: partial || false
      }
      model = SqlPager.model_name.to_s.camelize.constantize
      query = model.where(conditions)
      if locals.count > 1
        query.order("FIELD(locale,#{order_clause(locals)})")
      end
      if formats.count > 1
        query.order("FIELD(format,#{order_clause(formats)})")
      end
      query.map do |record|
        initialize_template(record)
      end
    end
    
    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end
    def normalize_array(array)
      array.map(&:to_s)
    end
    def order_clause(array)
      array.map(&lambda{|el|
        "\"#{el}\""
      }).join(",")
    end
    
    def initialize_template(record)
      source = record.body
      identifier = "Page - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.registered_template_handler(record.handler)
      
      details = {
        format: Mime[record.format],
        updated_at: record.updated_at,
        virtual_path: virtual_path(record)
      }
      
      ActionView::Template.new source, identifier, handler, details
    end
    
    def virtual_path(record)
      return record.path unless record.partial
      if index = record.path.rindex('/')
        record.path.insert(index + 1, '_')
      else
        "_#{record.path}"
      end
    end
  end
end