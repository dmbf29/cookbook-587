require 'nokogiri'

file = 'lib/chocolate.html'  # or 'strawberry.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# 0. put this inside of a message (and/or class)
# 1. call this from the controller

doc.search('.card__detailsContainer').first(5).map do |card_element|
  puts

  name = card_element.search('.card__titleLink').text.strip
  # 2. find the description
  # 3. create an instance of a recipe
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
