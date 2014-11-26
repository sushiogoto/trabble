class Trip < ActiveRecord::Base
  has_many :trip_users
  has_many :users, :through => :trip_users
  has_many :locations, :dependent => :destroy
  has_many :transportations, :dependent => :destroy
  has_many :accomodations, :dependent => :destroy
  acts_as_votable
  accepts_nested_attributes_for :locations, :allow_destroy => true
  accepts_nested_attributes_for :transportations, :allow_destroy => true
  accepts_nested_attributes_for :accomodations, :allow_destroy => true
end
