# frozen_string_literal: true

class EmployersController < InheritedResources::Base
  private

  def employer_params
    params.require(:employer).permit(:email, :name, :position, :privatenumber)
  end
end
