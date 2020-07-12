class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_idea_tags, dependent: :destroy
  has_many :idea_genre_tags, dependent: :destroy
  has_many :idea_tags, :through => :idea_idea_tags
  has_many :genre_tags, :through => :idea_genre_tags
  # 複合アイデア関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # 元アイデアに含める
  def includeIdeas(other_idea)
    followers << other_idea
  end
  
  # 元アイデアから外す
  def excludeIdeas(other_idea)
    active_relationships.find_by(followed_id: other_idea.id).destroy
  end
  
end
