# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  question   :text             not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "byebug"

class Question < ApplicationRecord
  validates :question, :poll_id, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    Question.left_outer_joins(answer_choices: :responses).where(questions: {id: self.id}).group("answer_choices.choice")
      .pluck("answer_choices.choice", "COUNT(responses.id)").to_h
    #     choices = self.answer_choices
    #     results = {}
    #     choices.each do |choice|
    #       results[choice.choice] = choice.responses.length
    #     end
    #     results
    #   end
    # choices = self.answer_choices.includes(:responses)
    # results = {}
    # choices.each do |choice|
    #   results[choice.choice] = choice.responses.length
    # end
    # results
  end
end
