require 'sql_pager/layout'

ActiveAdmin.register <%= singular_name.to_s.camelize %> do
  controller do
    authorize_resource 
    helper SqlPager::Layout::ViewHelper
  end
  # Uncomment this line when using CanCan
  # menu if: proc{ can?(:manage, <%= singular_name.to_s.camelize %>) }
  index do
    selectable_column
    id_column
    column :path, sortable: :path do |page|
      link_to page.path, page_path(page.path)
    end
    column :title, ->(page) { page.page_info.title }
    column :template, ->(page) { page.page_info.template }
    column :updated_at
    default_actions
  end
  show title: :path do |page|
    h3 page.page_info.title
    attributes_table do
      row :body do |page|
        pre page.body, class: 'prettyprint linenums'
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  sidebar "Page informations", only: :show do
    attributes_table_for <%= singular_name.to_s %>.page_info do
      row :path do
        link_to <%= singular_name.to_s %>.path, <%= singular_name.to_s %>_path(<%= singular_name.to_s %>.path)
      end
      row :template
    end
  end
  form :partial => 'admin/<%= singular_name.to_s %>/form'
end
