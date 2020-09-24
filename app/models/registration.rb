class Registration < ActiveRecord::Base
  belongs_to :user
  
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :answers

  delegate :name, to: :user
  delegate :email, to: :user
  delegate :nickname, to: :user
  delegate :username, to: :user

  validates :user, presence: true

  validates :user_id, uniqueness: { scope: :conference_id, message: 'already Registered!' }

end
