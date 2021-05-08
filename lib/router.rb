class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the Cookbook!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.create
    when 3 then @controller.import
    when 4 then @controller.mark_as_done
    when 5 then @controller.destroy
    when 0 then stop
    else
      puts "Please press 1, 2, 3, 4, 5, or 0"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Create a new recipe"
    puts "3 - Import a new recipe"
    puts "4 - Mark a recipe"
    puts "5 - Destroy a recipe"
    puts "0 - Stop and exit the program"
  end
end
