require "rails_helper"
#require "parsedate"

RSpec.describe ChecksController, :type => :controller do
  before do 
    params = {email: "jnegrete15@ucol.mx", name: "Alberto", position: "Developer", privatenumber: 159357}
    employeer1 = Employer.new(params)
    employeer1.save

    time = Time.at(15000000000)
    @check_ins = [time,time,time,time]
  end

  describe "get_employeers" do
    it "return the private numbers of employeers" do
      expect(controller.get_employeers()).to eq([159357])
    end
  end

  describe "get_month_days" do
    it 'return the number of the days by month' do
      #controller.get_month_days("2").equal? (19)
      expect(controller.get_month_days("2")).to eq(28)
    end
  end

  describe "calculate_average" do
    it 'return the averega of the hours' do
      expect(controller.calculate_average(39.68, 2)).to eq("19:84")
    end
  end
  
  describe "get_total_hours" do
    it 'return the sum of all the hours' do
      expect(ChecksController.new.get_total_hours(@check_ins)).to eq(85.6)
    end
  end
  

end