class Message < ActiveRecord::Base
  belongs_to :chat

  belongs_to :sender, polymorphic: true
end
