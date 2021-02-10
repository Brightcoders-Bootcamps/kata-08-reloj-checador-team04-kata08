class ChecksController < InheritedResources::Base

  private

  def check_params
    params.require(:check).permit(:privatenumber, :type_move)
  end

  def generate_report(date)
    check_days(get_month(date))
  end

  def generate_report_by_user(private_number)
    numbers = get_employees

    numbers.each do |num|
      check_days()
    end
  end

  def check_days(num, days, date)
    days = get_month(date)
    array = []

    (1..days).each  do |i|
      array[i] << 'Absence'
    end
  end

  def get_month(date)
    month = date[5..6]
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



