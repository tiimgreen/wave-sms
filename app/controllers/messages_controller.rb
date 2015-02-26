class MessagesController < ApplicationController

  def get_sms
    render 'get_sms.xml', content_type: 'application/xml'

    Message.create!(body: params.inspect)
  end
end
