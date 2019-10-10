class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :uid, :email, :filmarks_id
end
