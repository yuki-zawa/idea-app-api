class IdeaTag < ApplicationRecord
  has_many :idea_idea_tags, dependent: :destroy
  has_many :ideas, :through => :idea_idea_tags

  validates :user_id, uniqueness: { scope: [:name], message: "同じ名前のタグがあります." }
end
