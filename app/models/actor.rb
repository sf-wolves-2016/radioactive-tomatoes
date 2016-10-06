class Actor < ActiveRecord::Base
  has_many :roles
  has_many :movies, through: :roles
  has_many :reviews, as: :reviewable
  validates :name, uniqueness: true
end
