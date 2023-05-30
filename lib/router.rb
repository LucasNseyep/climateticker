class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the climateticker!!"
    puts "              --              "

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
    when 1 then @controller.search_internet_for_company
    when 0 then stop
    else
      puts "Please press 1 or 0"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - Search for a company"
    puts "0 - Stop and exit the program"
  end
end
