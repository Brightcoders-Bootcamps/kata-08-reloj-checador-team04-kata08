# frozen_string_literal: true

ActiveAdmin.register Check do
  menu label: 'Reports'
  index title: 'Reports' 
  #do
   # selectable_column
    #id_column
    #column :privatenumber
    #column :type_move
    #column :absence
    #column :created_at
    #actions
  #end

  action_item :view_site do
    link_to "View absences", "/sessions/show"
  end

  action_item :view_site do
    link_to "View prom", "/checks"
  end

  actions :all, :except => [:new]

  filter :privatenumber
  filter :type_move
  filter :created_at

end
