class <%= controller_class_name %>Controller < ApplicationController
  
  with_sql_resolver
  
  def show
    render params[:view_path]
  end
  
end