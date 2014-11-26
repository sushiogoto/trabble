class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  acts_as_votable
end
