class SessionsController < ApplicationController
  
  def create
    @employeer = Employer.find_by(privatenumber: params[:privatenumber])

    if @employeer
      puts 'si!!!!!!!!!!!!!!!!'
      @employeer = Check.create(privatenumber: @employeer.privatenumber, type_move: "check_in")
      #puts "Welcome #{@employeer.name}"
    else
      message = "Something went wrong, Make sure your private number is correct"
      #redirect_to 'session_path', notice: message
     puts 'noooooooooooooooo!!!!!!'
    end

  end

  def home
  end 
end
