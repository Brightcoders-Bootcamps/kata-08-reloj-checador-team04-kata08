class ChecksController < InheritedResources::Base

  private

  def check_params
    params.require(:check).permit(:privatenumber, :type_move)
  end

  def generate_report_by_user(month)

    days = get_month_days(month)
    employeers = get_employees

    employeers.each do |private_number|
      asis = check_attendance(private_number, month)
      puts "Employeer: #{private_number}, attendance: #{asis}, absences: #{days-asis}"
    end
  end

  def check_attendance(privatenumber, month)
    attendance = Check.where("privatenumber = #{privatenumber} AND type_move = 'check_in' AND extract(MONTH from created_at) = #{month}")
    #attendance = Check.where("privatenumber = 312312 AND type_move = 'check_in' AND extract(MONTH from created_at) = '2'")
    return attendance.length
  end

  def get_month_days(month)
    if month == "2"
      return 28
    elsif month == "4" || month == "6" || month == "9" || month == "11"
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



