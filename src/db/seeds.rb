# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |num|
  User.create!(email: "user#{num}@gmail.com", password: "password", password_confirmation: "password",
              remember_digest: "remember_digest#{num}", activation_digest: "activation_digest#{num}",
              activated_at: "activated_at#{num}", activated: "activated#{num}")
  Authorization.create!(user_id: num, uid: "uid#{num}", provider: "provider#{num}")
end

(1..10).each do |num|
  MultiIdea.create!(icon: "😄", title: "title#{num}", detail: "detail#{num}", priority: 2.1+num/20)
end

(1..20).each do |num|
  Idea.create!(icon: "😄", user_id: (num+1)/2, title: "title#{num}", detail: "detail#{num}", priority: 2.1+num/20)
  IdeaMultiIdea.create!(idea_id: num, multi_idea_id: (num+1)/2)
end

(1..30).each do |num|
  GenreTag.create!(name:"genre_tag#{num}", color:"#ffffff")
  IdeaTag.create!(name:"idea_tag#{num}")
end

(1..20).each do |num|
  IdeaIdeaTag.create!(idea_id: num, idea_tag_id: num)
  IdeaGenreTag.create!(idea_id: num, genre_tag_id: num)
end