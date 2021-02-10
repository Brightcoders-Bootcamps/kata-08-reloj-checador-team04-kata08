class ChecksController < InheritedResources::Base

  private

  def check_params
    params.require(:check).permit(:privatenumber, :type_move)
  end

  def generate_report_by_user(month)

    days = get_month_days(month)
    employeers = get_employees
    check_days()

    employeers.each do |num_employeer|
      check_attendace(num_employeer, month)
    end
  end

  def check_attendace(privatenumber, month)
    
    attendace = Check.where("privatenumber = #{privatenumber}", "created_at LIKE -02-", "type_move = check_in")
    attendace = Check.where("privatenumber = 312312", "created_at LIKE -02-", "type_move LIKE check_in")

  end

  def get_month_days(month)
    if month == '02'
      return 28
    elsif month == '04' || month == '06' || month == '09' || month == '11'
      return 30
    else
      return 31
    end
    
  end
  
  def get_employees()
    query = Employer.all
    numbers = []
    to_json_def(query)

    query.each do |number|
      numbers << number[:privatenumber]
    end

    return numbers
  end

  def to_json_def(query)
    query.map{|s| {status: s[0], hits: s[1].to_i, page_views: s[2].to_i} }
    puts query.to_json
  end
end



