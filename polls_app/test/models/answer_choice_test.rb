# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint(8)        not null, primary key
#  question_id :integer          not null
#  choice      :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class AnswerChoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
