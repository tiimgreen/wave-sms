class Message < ActiveRecord::Base
  belongs_to :chat

  belongs_to :sender, polymorphic: true

  def from_staff?
    sender_type == 'User'
  end

  def from_customer?
    sender_type == 'Customer'
  end
end
