class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation

  has_many :chats
  has_many :messages, as: :sender

  def owner?(org)
    org.owner == self
  end

  def name
    "#{first_name} #{last_name}"
  end
end
