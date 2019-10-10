class TmdbMovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :homepage
end
