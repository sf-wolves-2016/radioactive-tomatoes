class Actor < ActiveRecord::Base
  has_many :roles
  has_many :reviews, as: :reviewable
end
