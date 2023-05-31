# frozen_string_literal: true
require "tty-prompt"

class View
  def initialize
    @prompt = TTY::Prompt.new
  end

  def ask_for(item)
    # puts `clear`
    # puts "What #{item} are you looking for?"
    # gets.chomp
    @prompt.ask("What #{item} are you looking for?")
  end

  def ask_for_index
    puts 'Index?'
    gets.chomp.to_i - 1
  end

  def display_list(elements)
    puts `clear`
    elements.delete_at(-1)
    # elements.each_with_index do |element, index|
    #   puts "#{index + 1} #{element}"
    # end
    p elements.find_index(@prompt.select("Choose", elements)) #we can now return the index immediately

  end

  def looking_for(element)
    puts "Looking for '#{element}'..."
  end

  def retrieving(element, items)
    puts "Retrieving #{element} #{items} ..."
  end
end

# name = prompt.ask("What is your name?", default: ENV["USER"])
# puts name
