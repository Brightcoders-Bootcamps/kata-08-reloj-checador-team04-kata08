# frozen_string_literal: true

ActiveAdmin.register Check do
  menu label: 'Reports'
  index title: 'Reports'

  filter :privatenumber
  filter :type_move
  filter :created_at
end
