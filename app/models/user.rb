require 'bcrypt'

class User < ActiveRecord::Base
  has_many :comments
  has_many :reviews, foreign_key: :reviewer_id

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def login(email, password)
    @user = User.find_by_email(email)
    if @user.password == password
      sessions[:user_id] = @user.id
      return @user
    end
  end
end
