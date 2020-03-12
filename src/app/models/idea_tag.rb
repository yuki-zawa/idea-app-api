class IdeaTag < ApplicationRecord
  has_many :idea_idea_tags
  has_many :ideas, :through => :idea_idea_tags
end
