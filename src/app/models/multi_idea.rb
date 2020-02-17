class MultiIdea < ApplicationRecord
  has_many :ideas, :through => :idea_multi_ideas
end
