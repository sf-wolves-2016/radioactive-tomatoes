class Review < ActiveRecord::Base
  has_many :comments
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewable, polymorphic: true
end
