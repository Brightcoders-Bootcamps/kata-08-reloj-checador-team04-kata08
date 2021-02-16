require "rails_helper"

RSpec.describe ChecksController, :type => :controller do
  before do 
    params = {email: "jnegrete15@ucol.mx", name: "Alberto", position: "Developer", privatenumber: 159357}
    employeer1 = Employer.new(params)
    
  end

  describe "get_employeers" do
    it "return the private numbers of employeers" do
      controller.get_employeers().equal? ([159357])
    end
  end

end