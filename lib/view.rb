# frozen_string_literal: true

class View
  def ask_for(item)
    puts `clear`
    puts "What #{item} are you looking for?"
    gets.chomp
  end

  def ask_for_index
    puts 'Index?'
    gets.chomp.to_i - 1
  end

  def display_list(elements)
    puts `clear`
    elements.delete_at(-1)
    elements.each_with_index do |element, index|
      puts "#{index + 1} #{element}"
    end
  end

  def looking_for(element)
    puts "Looking for '#{element}'..."
  end

  def retrieving(element, items)
    puts "Retrieving #{element} #{items} ..."
  end
end
