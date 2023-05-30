class View
  def ask_for(item)
    puts `clear`
    puts "What #{item} are you looking for?"
    gets.chomp
  end

  def ask_for_index
    puts "Index?"
    return gets.chomp.to_i - 1
  end

  def display_list(elements)
    elements.each_with_index do |element, index|
      puts "#{index + 1} #{element}"
    end
  end

  def looking_for(element)
    puts "Looking for '#{ingredient}' recipes on the Internet..."
  end

  def importing(recipe)
    puts "Importing '#{recipe}'..."
  end
end
