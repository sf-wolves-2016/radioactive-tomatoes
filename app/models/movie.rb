class Movie < ActiveRecord::Base
  has_many :reviews, as: :reviewable
  has_many :roles
  has_many :actors, through: :roles
end
