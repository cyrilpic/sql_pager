class PagesController < ApplicationController
  
  with_sql_resolver
  
  def show
    render params[:page]
  end
end
