class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Idea"
  belongs_to :followed, class_name: "Idea"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
