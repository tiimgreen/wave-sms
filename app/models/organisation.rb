class Organisation < ActiveRecord::Base
  has_many :users
  has_one :owner, class_name: 'User'
end
