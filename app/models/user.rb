require 'bcrypt'

class User < ActiveRecord::Base
  has_many :comments
  has_many :reviews, foreign_key: :reviewer_id
  validates :username, :email, presence: true

  include BCrypt

  has_secure_password

end
