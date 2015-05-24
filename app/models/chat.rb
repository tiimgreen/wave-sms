class Chat < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :customer

  has_many :messages
end
