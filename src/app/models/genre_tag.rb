class GenreTag < ApplicationRecord
  has_many :idea_genre_tags
  has_many :ideas, :through => :idea_genre_tags

  validates :user_id, uniqueness: { scope: [:name], message: "同じ名前のタグがあります." }
end
