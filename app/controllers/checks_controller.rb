# frozen_string_literal: true

class ChecksController < InheritedResources::Base
  #private

  def check_params
    params.require(:check).permit(:privatenumber, :type_move)
  end

  def generate_report_by_user(month)
    absences = []
    days = get_month_days(month)
    employeers = get_employeers

    employeers.each do |private_number|
      asis = check_attendance(private_number, month)
      #puts "Employeer: #{private_number}, attendance: #{asis}, absences: #{days - asis}"
      absences << {private_number: "#{private_number}", absence: "#{days-asis}"}
    end
    return absences
  end

  def get_average(type_move)
    checks =  get_check(type_move)
    total_hours = get_total_hours(checks)
    average = calculate_average(total_hours, check_ins.length)
  end

  def check_attendance(privatenumber, month)
    attendance = Check.where("privatenumber = #{privatenumber} AND type_move = 'check_in' AND extract(MONTH from created_at) = #{month}")
    attendance.length
  end

  def get_month_days(month)
    case month
    when "2"
      28
    when "4", "6", "9", "11"
      30
    else
      31
    end
  end

  def get_employees
    query = Employer.all
    numbers = []
    to_json_def(query)

    query.each do |number|
      numbers << number[:privatenumber]
    end

    numbers
  end

  def to_json_def(query)
    query.map { |s| { status: s[0], hits: s[1].to_i, page_views: s[2].to_i } }
    puts query.to_json
  end

  def generate_average_report(month)
    employers = get_employees
    report_average = []

    employers.each do |employeer|
      report_average << { private_number: employeer, 
        average_check_in: get_average(employeer, 'check_in', month),
        average_check_out: get_average(employeer, 'check_out', month) }
    end

    return report_average
  end

  def get_average(private_number, type_move, month)
    checks = get_checks(private_number, type_move, month)
    total_hours = get_total_hours(checks)
    average = calculate_average(total_hours, checks.length)
  end

  def get_total_hours(checks)
    sum = 0
    checks.each do |f2|
      sum += f2.strftime('%k.%M').to_f
    end
    puts
    return sum

  end


  def get_checks(private_number, type_move, month)
    horas = []
    checks = Check.where("privatenumber = #{private_number} AND type_move = '#{type_move}' AND extract(MONTH from created_at) = #{month}")
    #Check.where("privatenumber = 312312 AND type_move = 'check_in' AND extract(MONTH from created_at) = 2")
    checks.each do |h|
      horas << h[:created_at]
    end

    return horas
  end

  def calculate_average(total, num_elements)
    if(total == 0 || num_elements == 0)
      return "There's not checks yet."
    else
      avg = total / num_elements
      avg1 = avg.to_s
      avg1['.'] = ':'
      return avg1[0..4]

    end
    
  end

  def index
    @month_average = params[:month_average] == nil ? Time.now.month : params[:month_average]
    @average = generate_average_report(@month_average)  

  end

  def month_average 
    @average = generate_average_report(@month_average) 
    redirect_to :index 
  end
end
