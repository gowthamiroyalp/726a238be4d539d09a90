class Answer < ActiveRecord::Base
  has_many :answers
  has_many :questions, through: :answers

  validates :title, presence: true
end
