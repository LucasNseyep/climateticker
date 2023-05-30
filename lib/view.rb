class View
  def ask_for(item)
    puts "What #{item} are you looking for?"
    gets.chomp
  end

  def display_list(elements)
    elements.each_with_index do |element, index|
      puts "#{index + 1} #{element}"
    end
  end
end
