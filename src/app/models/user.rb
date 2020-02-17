class User < ApplicationRecord
  has_many :authorizations
  has_many :ideas
end
