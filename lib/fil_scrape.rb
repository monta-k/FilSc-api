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
    return { pages: pages }
  end

  def page_scrape(page)
    movie = []

    page.times do |i|
      html2 = open(BASE_URL+ "users/monta.k/clips?page=#{i + 1}") do |f|
        charset = f.charset
        f.read
      end
      doc2 = Nokogiri::HTML.parse(html2, nil, charset)
      movie_a = movie_detail_scrape(doc2)
      movie.concat(movie_a)
      puts movie.count
    end

     return { title: title, movie: movie}
  end

  def movie_detail_scrape
    Parallel.map(doc2.xpath("//h3[@class='c-movie-item__title']//a")) do |item|
      html3 = open(BASE_URL + item[:href]) do |f|
        charset = f.charset
        f.read
      end
      doc3 = Nokogiri::HTML.parse(html3, nil, charset)
      movie_title = doc3.xpath("//h2[@class='p-content-detail__title']")[0].text
      movie_length = doc3.xpath("//h3[@class='p-content-detail__other-info-title']")[-1].text.delete("^0-9").to_i
      movie_score = doc3.xpath("//div[@class='c-rating__score']")[0].text
      movie_img = doc3.css('.c-content__jacket > img').first.try(:attribute, "src").try(:value)
      movie_link = base_url + item[:href]
      [movie_title, movie_length, movie_score, movie_img, movie_link]
    end
  end
end 