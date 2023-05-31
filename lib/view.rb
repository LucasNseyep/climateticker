# frozen_string_literal: true
require "tty-prompt"

class View
  def initialize
    @prompt = TTY::Prompt.new
    @answer = TTY::Prompt.new
  end

  def ask_for(item)
    @prompt.ask("What #{item} are you looking for?")
  end

  def display_list_and_select(elements)
    # issue for when you have multiple companies with the same name, which shouldn't be a thing
    elements.delete_at(-1)
    elements.find_index(@prompt.select("Choose", elements, filter: true))
  end

  def looking_for(element)
    puts "Looking for '#{element}'..."
  end

  def retrieving(element, items)
    puts "Retrieving #{element} #{items}..."
  end

  def display_answers(elements)
    elements.each do |element|
      @answer.ok("> " + element)
      puts "\n"
    end
  end
end
