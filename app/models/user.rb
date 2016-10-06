require 'bcrypt'

class User < ActiveRecord::Base
  has_many :comments
  has_many :reviews, foreign_key: :reviewer_id

  include BCrypt

  has_secure_password

end
