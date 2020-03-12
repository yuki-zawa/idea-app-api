class GenreTagSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :status

  has_many :ideas, :through => :idea_genre_tags, serializer: IdeaSerializer
end