class IdeaGenreTag < ApplicationRecord
  belongs_to :idea
  belongs_to :genre_tag
end
