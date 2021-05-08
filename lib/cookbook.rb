require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # contains instances of Recipe
    @csv_file_path = csv_file_path
    load_csv # instance method
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # get a recipe instance
    recipe = @recipes[index]
    # change the state of that instance
    recipe.mark_as_done!
    # save
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # row is acting like a hash
      # CRUD - Update
      # hash[key] = new_value
      row[:done] = row[:done] == 'true'
      # row[:rating] = row[:rating].to_i
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
