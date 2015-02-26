class MessagesController < ApplicationController

  def get_sms
    render 'get_sms.xml', content_type: 'application/xml'

    # customer = Customer.find_or_create_by(phone_number: params[:phone_number])

    Message.create!(body: params.inspect)
  end
end
