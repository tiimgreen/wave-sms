class Customer < ActiveRecord::Base
  belongs_to :organisation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name,   presence: true, length: { maximum: 50 }
  validates :last_name,    presence: true, length: { maximum: 50 }
  validates :last_name,    length: { maximum: 50 }
  validates :email,        presence: true
  validates :email,        format: { with: VALID_EMAIL_REGEX },
                           uniqueness: { case_sensitive: false },
                           unless: Proc.new { |c| c.email.blank? }
  validates :phone_number, presence: true, length: { maximum: 20 }

  has_one :chat
  has_many :messages, as: :sender
  belongs_to :user, foreign_key: :staff_id

  def name
    "#{first_name} #{last_name}"
  end

  def display_details
    name.present? ? name : email
  end

  def phone_display_details
    name.present? ? name : phone_number
  end

  def address_fields
    %i( address_line_1 address_line_2 address_line_3 city postal_code country )
  end

  def is_taken?
    staff_id.present?
  end

  def is_taken_by?(other_user)
    user == other_user
  end

  def has_unseen_message?
    true
  end
end
