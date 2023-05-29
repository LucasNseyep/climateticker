require_relative "./word_frequency"
require_relative "./text_analyzer"

# word_frequency.rb interface

# text_path = File.dirname(__FILE__) + "/source-text.txt"
# stop_words_path = File.dirname(__FILE__) + "/stop_words.txt"

# p most_common_words(text_path, stop_words_path, 1)

# text_analyzer.rb interface

text = File.read(File.dirname(__FILE__) + "/source-text.txt")

pp analyze(text)
