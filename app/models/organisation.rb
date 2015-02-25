class Organisation < ActiveRecord::Base
  has_many :users
  has_many :customers, dependent: :destroy
  has_one :owner, class_name: 'User'
end
