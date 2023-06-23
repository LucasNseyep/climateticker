# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'

class Router
  def initialize(controller)
    @controller = controller
    @running    = true
    @display    = TTY::Prompt.new
  end

  def run
    welcome
    while @running
      action = display_and_select_tasks
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 0 then @controller.search_internet_for_company
    when 1 then welcome
    when 2 then stop
    end
  end

  def welcome
    puts `clear`
    puts 'Welcome to'
    puts "
     ██████ ██      ██ ███    ███  █████  ████████ ███████ ████████ ██  ██████ ██   ██ ███████ ██████
    ██      ██      ██ ████  ████ ██   ██    ██    ██         ██    ██ ██      ██  ██  ██      ██   ██
    ██      ██      ██ ██ ████ ██ ███████    ██    █████      ██    ██ ██      █████   █████   ██████
    ██      ██      ██ ██  ██  ██ ██   ██    ██    ██         ██    ██ ██      ██  ██  ██      ██   ██
     ██████ ███████ ██ ██      ██ ██   ██    ██    ███████    ██    ██  ██████ ██   ██ ███████ ██   ██".colorize(:light_green)
    print "                                                                                        by LucasNseyep\n"
    disclaimer
  end

  def disclaimer
    print "                 [Disclaimer] So far, climateticker can only be used for US companies
    ".colorize(:light_magenta)
    puts "\n"
  end

  def stop
    @running = false
  end

  def display_and_select_tasks
    options = ['Search for a company', 'Clear previous output', 'Stop and exit the program']
    options.find_index(@display.select('What do you want to do next?', options, cycle: true))
  end
end
