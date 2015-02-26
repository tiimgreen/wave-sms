class MessagesController < ApplicationController

  def get_sms
    @path = BASE_URL + '/get-sms'

    render content_type: 'application/xml'
  end
end
