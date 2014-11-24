class Trip < ActiveRecord::Base
  has_many :trip_users
  has_many :users, :through => :trip_users
  has_many :locations
  acts_as_votable
end
