class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :score, :image, :link, :user_id
end
