class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :status, :activated, :token
  has_many :authorizations
end
