class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_tags
  has_many :genre_tags
  has_many :multi_ideas, :through => :idea_multi_ideas
end
