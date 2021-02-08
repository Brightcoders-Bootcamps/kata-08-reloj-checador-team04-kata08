class EmployersController < InheritedResources::Base

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id]) 
  end

  private

    def employer_params
      params.require(:employer).permit(:email, :name, :position, :privatenumber)
    end

end
