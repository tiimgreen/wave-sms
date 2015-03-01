module CustomersHelper

  # Takes a params hash and formats the phone number
  def parse_phone_number_in_params(cus_params)
    cp = cus_params
    phone_number = cp[:phone_number]
    phone_number.insert(0, '+') if phone_number[0..1] == '44'

    cp.tap do |params_hash|
      params_hash['phone_number'] = Phoner::Phone.parse(phone_number, country_code: '44').to_s
    end
  end
end
