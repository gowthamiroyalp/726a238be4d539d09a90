class Question < ActiveRecord::Base
  belongs_to :topic

  has_many :answers, dependent: :delete_all

  validates :title, :question_type_id, presence: true
  validate :existing_answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  private

  def existing_answers
    errors.add(:base, 'Must have answers') if answers.blank?
  end
end
