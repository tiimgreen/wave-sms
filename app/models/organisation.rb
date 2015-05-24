class Organisation < ActiveRecord::Base
  has_many :users
  has_many :customers, dependent: :destroy
  has_many :chats
  has_one :owner, class_name: 'User'

  validate :name_cannot_be_reserved_word

  validates :permalink,   presence: true, uniqueness: { case_sensitive: false }
  validates :name,        presence: true
  validates :staff_limit, presence: true

  before_validation :save_permalink

  def to_param
    name.parameterize
  end

  def staff
    users
  end

  # Compiles list of taken URLs from routes
  def taken_names
    taken_routes = []

    Rails.application.routes.routes.each do |route|
      route = route.path.spec.to_s.sub('(.:format)', '').split('/')[1]
      taken_routes << route unless route.nil? || route[0] == ':'
    end

    taken_routes.uniq
  end

  def name_cannot_be_reserved_word
    errors.add(:name, 'is already taken') if taken_names.include?(name.parameterize)
  end

  private

    def save_permalink
      self.permalink = name.parameterize
    end
end
