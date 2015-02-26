class Customer < ActiveRecord::Base
  belongs_to :organisation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  length: { maximum: 50 }
  validates :email,      format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }

  has_one :chat

  def name
    "#{first_name} #{last_name}"
  end
end
