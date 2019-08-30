require 'open-uri'
require 'nokogiri'
require 'parallel'

 class FilScrape
  def self.scrape(userId)
    base_url = 'https://filmarks.com/'

    charset = nil
    html = open(base_url + "users/#{userId}/clips") do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    title = doc.title
    page = doc.xpath("//ul[@class='c-pagination__list']//li").count

    movie = []

    page.times do |i|
      html2 = open(base_url + "users/monta.k/clips?page=#{i + 1}") do |f|
        charset = f.charset
        f.read
      end
      doc2 = Nokogiri::HTML.parse(html2, nil, charset)
      movie_a = Parallel.map(doc2.xpath("//h3[@class='c-movie-item__title']//a")) do |item|
        html3 = open(base_url + item[:href]) do |f|
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
      movie.concat(movie_a)
      puts movie.count
    end

     return { title: title, movie: movie}
  end
end 