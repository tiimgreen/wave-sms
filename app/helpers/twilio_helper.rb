module TwilioHelper
  def twilio_area_code(area_code)
    return '+44' + area_code[1..-1] if area_code[0] == '0'
    area_code
  end

  def format_number(number, area_code)
    return number if area_code == 'none' || area_code.nil?

    twilio_code = twilio_area_code(area_code)
    "#{area_code} #{number.split(twilio_code)[1]}"
  end
end
