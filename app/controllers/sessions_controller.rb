class SessionsController < ApplicationController

  @@count_check = 0

  def create
    @employeer = Employer.find_by(privatenumber: params[:privatenumber])

    if @employeer && @@count_check == 0
      @employeer = Check.create(privatenumber: @employeer.privatenumber, type_move: "check_in")
      redirect_to sessions_login_path, :notice => "Exito"
      @@count_check += 1
    elsif @employeer && @@count_check == 1
      @employeer = Check.create(privatenumber: @employeer.privatenumber, type_move: "check_out")
      redirect_to sessions_login_path, :notice => "Exito"
      @@count_check += 1
    elsif @employeer && @@count_check > 1
      redirect_to sessions_login_path, :alert => "Ya duermete bro"
    else
      redirect_to sessions_login_path, :alert => "Fracaso total"
    end

  end

  def home
  end 
end
