class MultiIdea < ApplicationRecord
  has_many :idea_multi_ideas
  has_many :ideas, :through => :idea_multi_ideas
end
