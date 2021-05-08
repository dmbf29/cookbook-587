require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

# service object is a controller helper
# moves logic outside of the controller
class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # file = 'lib/chocolate.html'  # or 'strawberry.html'
    file = open("https://www.allrecipes.com/search/results/?search=#{@keyword}").read
    doc = Nokogiri::HTML(file, nil, 'utf-8')

    # 0. put this inside of a method (and/or class)
    # 1. call this from the controller

    doc.search('.card__detailsContainer').first(5).map do |card_element|
      name = card_element.search('.card__titleLink').text.strip
      # 2. find the description
      description = card_element.search('.card__summary').text.strip
      rating = card_element.search('.rating-star.active').count
      url = card_element.search('.card__titleLink').attribute('href').value
      prep_time = fetch_prep_time(url)
      # 3. create an instance of a recipe
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
  end

  def fetch_prep_time(url)
    file = open(url).read
    doc = Nokogiri::HTML(file, nil, 'utf-8')
    doc.search('.recipe-meta-item-body').first.text.strip
  end
end
# 4. give the view our new array of instances



# search by html tags
# doc.search('h1')

# search by id
# doc.search('#banner')

# search by class
# doc.search('.class_name')

# search by parent and child
# p doc.search('.card__detailsContainer .card__titleLink')

# the element needs BOTH classes
# p doc.search('.card__detailsContainer.card__titleLink')

# .search always returns an array

# doc_element.text
# p doc.search('h1').text.strip
