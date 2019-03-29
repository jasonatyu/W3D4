# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Poll.delete_all
Question.delete_all
AnswerChoice.delete_all
Response.delete_all

usernames = []
until usernames.length == 20
  username = Faker::Internet.username
  usernames << username unless usernames.include?(username)
end

usernames.each { |username| User.create!("username" => username) }

Poll.create!({"title" => "Favorite Foods", "user_id" => User.first.id})
Question.create!({"question" => "Do you like bananas?", "poll_id" => Poll.last.id})
AnswerChoice.create!({"question_id" => Question.last.id, "choice" => "Yes"})
AnswerChoice.create!({"question_id" => Question.last.id, "choice" => "No"})
AnswerChoice.create!({"question_id" => Question.last.id, "choice" => "Gross!"})
Response.create!({"user_id" => User.last.id, "answer_id" => AnswerChoice.last.id})
