class UserSerializer < ActiveModel::Serializer
  attributes :username, :id, :email
end
