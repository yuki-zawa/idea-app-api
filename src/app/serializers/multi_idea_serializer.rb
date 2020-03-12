class MultiIdeaSerializer < ActiveModel::Serializer
  attributes :id, :icon, :title, :detail, :priority, :status, :created_at, :updated_at

  has_many :ideas, :through => :idea_multi_ideas, serializer: IdeaSerializer
end