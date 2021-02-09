class ChecksController < InheritedResources::Base

  private

    def check_params
      params.require(:check).permit(:privatenumber, :type_move)
    end

end
