class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name] # string
    @description = attributes[:description] # string
    @rating = attributes[:rating] # string
    @prep_time = attributes[:prep_time] # string
    @done = attributes[:done] || false # boolean
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = !@done
  end
end

# no longer intializing this way
# Recipe.new('burger', 'bun and meat', 5)


# recipe = Recipe.new
# recipe.name = "burger"

# New way!
# Recipe.new(
#   description: 'bun and meat',
#   name: 'burger',
#   rating: 5
# )
