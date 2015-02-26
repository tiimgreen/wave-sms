class Customer < ActiveRecord::Base
  belongs_to :organisation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  length: { maximum: 50 }
  validates :email,      format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }

  has_one :chat
  has_many :messages, as: :sender
  belongs_to :user, foreign_key: :staff_id

  def name
    "#{first_name} #{last_name}"
  end

  def address_fields
    %i( address_line_1 address_line_2 address_line_3 city postal_code country )
  end
end
