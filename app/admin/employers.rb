# frozen_string_literal: true

ActiveAdmin.register Employer do
  permit_params :name, :email, :position, :privatenumber
end
