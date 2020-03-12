class IdeaTagSerializer < ActiveModel::Serializer
  attributes :id, :name, :status

  has_many :ideas, :through => :idea_idea_tags, serializer: IdeaSerializer
end