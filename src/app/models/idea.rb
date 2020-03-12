class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_idea_tags
  has_many :idea_genre_tags
  has_many :idea_multi_ideas
  has_many :idea_tags, :through => :idea_idea_tags
  has_many :genre_tags, :through => :idea_genre_tags
  has_many :multi_ideas, :through => :idea_multi_ideas
end
