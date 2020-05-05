require 'open-uri'
require 'nokogiri'
require 'parallel'

class FilScrape
  include ActiveModel::Model
  include ActiveModel::Attributes

  BASE_URL = 'https://filmarks.com'.freeze
  attribute :userId

  def self.find_user(search_id)
    charset = nil
    html = URI(BASE_URL + "/users/#{search_id}").open do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    url = BASE_URL + "/users/#{search_id}"
    profile_image = doc.css('.p-profile__avator > img').first.try(:attribute, 'src').try(:value)
    profile_name = doc.xpath("//h2[@class='p-profile__name']/text()").to_s
    profile_id = doc.xpath("//span[@class='p-profile__account']")[0].text
    { url: url, profileImage: profile_image, profileName: profile_name, profileId: profile_id }
    # page = doc.xpath("//ul[@class='c-pagination__list']//li").count
  end

  def self.clip_movies_page(user_id)
    charset = nil
    html = URI(BASE_URL + "/users/#{user_id}/clips").open do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    pages = doc.xpath("//ul[@class='c-pagination__list']//li").count
    pages = 1 if pages.zero?
    { pages: pages }
  end

  def self.clip_movies(user_id, page)
    charset = nil
    html = URI(BASE_URL + "/users/#{user_id}/clips?page=#{page}").open do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    movies = movie_detail_scrape(doc)
    movies
  end

  def self.movie_detail_scrape(doc)
    Parallel.map(doc.xpath("//h3[@class='c-content-item__title']//a")) do |item|
      charset = nil
      html = URI(BASE_URL + "/#{item[:href]}").open do |f|
        charset = f.charset
        f.read
      end
      item_doc = Nokogiri::HTML.parse(html, nil, charset)
      set_movie_detail(item, item_doc)
    end
  end

  def self.set_movie_detail(item, doc)
    movie_title = doc.css('.p-content-detail__title > span').text
    movie_length = doc.xpath("//h3[@class='p-content-detail__other-info-title']")[-1].text.delete('^0-9').to_i
    movie_score = doc.xpath("//div[@class='c-rating__score']")[0].text
    movie_img = doc.css('.c-content__jacket > img').first.try(:attribute, 'src').try(:value)
    movie_link = BASE_URL + "/#{item[:href]}"
    { title: movie_title, length: movie_length, score: movie_score, image: movie_img, link: movie_link }
  end
end
