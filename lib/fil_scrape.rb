require 'open-uri'
require 'nokogiri'
require 'parallel'

 class FilScrape
  include ActiveModel::Model
  include ActiveModel::Attributes

  BASE_URL = 'https://filmarks.com'
  attribute :userId
  
  def self.find_user(searchId)
    charset = nil
    html = open(BASE_URL + "/users/#{searchId}") do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    url = BASE_URL + "/users/#{searchId}"
    profile_image = doc.css('.p-profile__avator > img').first.try(:attribute, "src").try(:value)
    profile_name = doc.xpath("//h2[@class='p-profile__name']/text()").to_s
    profile_id = doc.xpath("//span[@class='p-profile__account']")[0].text
    return { url: url, profile_image: profile_image, profile_name: profile_name, profile_id: profile_id}
    # page = doc.xpath("//ul[@class='c-pagination__list']//li").count
  end

  def self.clip_movies_page(userId)
    charset = nil
    html = open(BASE_URL + "/users/#{userId}/clips") do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    pages = doc.xpath("//ul[@class='c-pagination__list']//li").count
    pages = 1 if pages == 0
    return { pages: pages }
  end

  def self.clip_movies(userId, page)
    charset = nil
    html = open(BASE_URL + "/users/#{userId}/clips?page=#{page}") do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    movies = movie_detail_scrape(doc)
    return movies
  end

  def self.movie_detail_scrape(doc)
    Parallel.map(doc.xpath("//h3[@class='c-movie-item__title']//a")) do |item|
      charset = nil
      html = open(BASE_URL + "/#{item[:href]}") do |f|
        charset = f.charset
        f.read
      end
      item_doc = Nokogiri::HTML.parse(html, nil, charset)
      movie_title = item_doc.css('.p-content-detail__title > span').text
      movie_length = item_doc.xpath("//h3[@class='p-content-detail__other-info-title']")[-1].text.delete("^0-9").to_i
      movie_score = item_doc.xpath("//div[@class='c-rating__score']")[0].text
      movie_img = item_doc.css('.c-content__jacket > img').first.try(:attribute, "src").try(:value)
      movie_link = BASE_URL + "/#{item[:href]}"
      { title: movie_title, length: movie_length, score: movie_score, image: movie_img, link: movie_link }
    end
  end
end 