class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :status, :activated, :token
end
