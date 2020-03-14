class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :icon, :title, :detail, :priority, :status, :created_at, :updated_at
  
  has_one :user
  has_many :genre_tags, :through => :idea_genre_ideas, serializer: GenreTagSerializer
  has_many :idea_tags, :through => :idea_idea_ideas, serializer: IdeaTagSerializer
  has_many :multi_ideas, :through => :idea_multi_ideas, serializer: MultiIdeaSerializer
end