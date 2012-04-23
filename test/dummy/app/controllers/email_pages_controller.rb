class EmailPagesController < ApplicationController
  
  with_sql_resolver :email_page
  
  def show
    render params[:view_path]
  end
  
end