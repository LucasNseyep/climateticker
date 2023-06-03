# frozen_string_literal: true

require 'colorize'
require 'tty-prompt'

class View
  def initialize
    @display = TTY::Prompt.new
  end

  def ask_for(item)
    @display.ask("What #{item} are you looking for?")
  end

  def display_list_and_select(elements)
    # issue for when you have multiple companies with the same name, which shouldn't be a thing
    elements.delete_at(-1)
    elements.find_index(@display.select('Choose', elements, filter: true))
  end

  def looking_for(element)
    puts "Looking for '#{element.to_s.colorize(:green)}'..."
  end

  def retrieving(element, items)
    puts "Retrieving #{element.to_s.colorize(:green)} #{items}..."
  end

  def display_answers(elements)
    elements.each do |element|
      @display.ok("> #{element}")
      puts "\n"
    end
  end

  def invalid_name
    puts "Please enter a valid and existing name".colorize(:light_yellow)
  end

  def reports_not_found
    puts "Sorry, no reports found :/".colorize(:light_yellow)
  end

  def ask_for_full_paragraphs
    @display.yes?("Do you want the full paragraphs?")
  end
end
