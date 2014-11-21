class Trip < ActiveRecord::Base
  has_many :trip_users
  has_many :users, :through => :trip_users
  acts_as_votable
end
