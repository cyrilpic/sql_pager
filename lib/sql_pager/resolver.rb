module SqlPager
  class Resolver < ActionView::Resolver

    # Provide only
    @@singleton__instances__ = {}
    @@singleton__mutex__ = Mutex.new
    def self.instance model = SqlPager.model_name, filter = nil
      singleton_name = normalize_singleton_name(model, filter)
      return @@singleton__instances__[singleton_name] if @@singleton__instances__[singleton_name]
      @@singleton__mutex__.synchronize {
        return @@singleton__instances__[singleton_name] if @@singleton__instances__[singleton_name]
        @@singleton__instances__[singleton_name] = new(model, filter)
      }
      @@singleton__instances__[singleton_name]
    end

    # Based on singleton
    def _dump(depth = -1)
      ''
    end
    def clone
      raise TypeError, "can't clone instance of singleton #{self.class}"
    end
    def dup
      raise TypeError, "can't dup instance of singleton #{self.class}"
    end

    private
    def self.normalize_singleton_name(model, filter)
      if filter
        "#{model.to_s}_#{filter.to_s}".to_sym
      else
        "#{model.to_s}".to_sym
      end
    end

    def initialize model, filter
      @model = model.to_s.camelize.constantize
      @filter = filter
      super()
    end
    private_class_method :new

    def find_templates(name, prefix, partial, details, outside_app_allowed=false)
      prefix = normalize_prefix(prefix)
      locals = normalize_array(details[:locale])
      formats = normalize_array(details[:formats])
      conditions = {
        path: normalize_path(name, prefix),
        handler: normalize_array(details[:handlers]),
        format: formats,
        locale: locals,
        partial: partial || false
      }
      conditions[SqlPager.filter_column] = @filter unless @filter.nil?
      query = @model.where(conditions)
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

    def normalize_prefix(prefix)
      prefix == @model.to_s.underscore.pluralize ? "" : prefix
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
      identifier = "#{@model.to_s} - #{record.id} - #{record.path.inspect}"
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
