# frozen_string_literal: true

class ChecksController < InheritedResources::Base
  #private

  def check_params
    params.require(:check).permit(:privatenumber, :type_move)
  end

  def generate_report_by_user(month)
    absences = []
    days = get_month_days(month)
    employeers = get_employees

    employeers.each do |private_number|
      asis = check_attendance(private_number, month)
      #puts "Employeer: #{private_number}, attendance: #{asis}, absences: #{days - asis}"
      absences << {private_number: "#{private_number}", absence: "#{days-asis}"}
    end
    return absences
  end

  def check_attendance(privatenumber, month)
    attendance = Check.where("privatenumber = #{privatenumber} AND type_move = 'check_in' AND extract(MONTH from created_at) = '2'")
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

  def get_average
    check_ins = get_check_ins
    total_hours = get_total_hours(check_ins)
    average = calculate_average(total_hours, check_ins.length)
  end

  def get_total_hours(check_ins)
    sum = 0
    check_ins.each do |f2|
      sum += f2.strftime('%k.%M').to_f
    end
    sum
  end

  def get_check_ins
    fechas = []
    check_ins = Check.where("type_move = 'check_in'")
    check_ins.each do |h|
      fechas << h[:created_at]
    end
    fechas
  end

  def calculate_average(total, num_elements)
    avg = total / num_elements
    avg1 = avg.to_s
    avg1['.'] = ':'
    avg1[0..4]
  end
end
