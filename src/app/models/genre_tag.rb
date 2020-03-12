class GenreTag < ApplicationRecord
  has_many :idea_genre_tags
  has_many :ideas, :through => :idea_genre_tags
end
