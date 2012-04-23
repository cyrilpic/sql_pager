class <%= controller_class_name %>Controller < ApplicationController
  
  with_sql_resolver :<%= singular_name.to_s %>
  
  def show
    render params[:view_path]
  end
  
end