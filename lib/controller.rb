require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask user for a name
    name = @view.ask_for('name')
    # Ask user for a description
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep time')
    # Instantiate a recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # Store the recipe in the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display the recipes
    display_recipes
    # Ask which recipe? (get the index)
    index_of_recipe = @view.ask_for_index
    # Remove the recipe from the Cookbook
    @cookbook.remove_recipe(index_of_recipe)
  end

  def import
    # ask user for keyword
    keyword = @view.ask_for('keyword')
    # search the internet (our file) for the thing
    recipes = ScrapeAllrecipesService.new(keyword).call
    # display things
    @view.display(recipes)
    # ask which one they want to save
    index = @view.ask_for_index
    # get that one thing
    recipe = recipes[index]
    # give it to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display all the recipes
    display_recipes
    # ask user for index
    index = @view.ask_for_index
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    # Retrieve the recipes from the Cookbook
    recipes = @cookbook.all
    # Display the recipes (ask the view)
    @view.display(recipes)
  end
end
