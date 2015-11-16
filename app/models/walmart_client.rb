class WalmartClient
  def self.find_reviews(product_id, filter_string = nil)
    WalmartClient.new.find_reviews(product_id, filter_string)
  end

  def find_reviews(product_id, filter_string = nil)
    reviews = download_reviews(product_id)
    if filter_string
      reviews = filter_reviews(reviews, filter_string)
    end
    reviews
  end

  private

  def download_reviews(product_id)
    # TODO download all
    url = "http://www.walmart.com/reviews/api/product/#{product_id}?limit=100&page=0&sort=helpful&filters=&showProduct=false"
    str = RestClient.get url
    json = JSON.parse(str)
    html = json['reviewsHtml']
    doc = Nokogiri::HTML(html)

    nodes = doc.css('.js-customer-review-text')
    nodes.map do |node|
      Review.new(node.text)
    end
  end

  def filter_reviews(reviews, str)
    words = str.split(' ').map { |w| w.strip }
    reviews.select do |review|
      words.all? do |word|
        review.text.include?(word)
      end
    end
  end
end
