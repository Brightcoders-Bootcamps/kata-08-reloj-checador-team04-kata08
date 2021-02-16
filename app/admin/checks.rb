ActiveAdmin.register Check do

  menu label: "Reports"

  filter :privatenumber
  filter :type_move
  filter :created_at

  #index download_links: [:pdf]

end
