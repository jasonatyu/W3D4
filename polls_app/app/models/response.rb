# == Schema Information
#
# Table name: responses
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validates :user_id, :answer_id, presence: true
  validate :not_duplicate_response
  validate :not_author 

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    Response.joins(question: :responses).where.not(responses: {id: self.id}).distinct
  end

  def respondent_already_answered?
    sibling_responses.where(user_id: self.user_id).exists?
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:duplicate] << "You already responded to this question."
    end
  end

  #question -> poll -> author -> compare?
  def is_author?
    Response.joins(question: :poll).where("polls.user_id = ?", self.user_id).exists?
  end

  def not_author 
    if is_author?
        errors[:author_error] << "You can\'t respond to your own poll."
    end
  end
end
