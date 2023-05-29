# rubocop:disable Metrics/MethodLength
def open_file(file_name, array)
  File.open(file_name, "r").each_line do |line|
    array.append(line)
  end
end

def most_common_words(file_name, stop_words_file_name, number_of_word)
  # TODO: return hash of occurences of number_of_word most frequent words
  words = []
  common_word = {}
  stop_words = []
  open_file(file_name, words)
  open_file(stop_words_file_name, stop_words)
  words = words.join.gsub("\n", " ").split
  words.map { |word| word.downcase! }
  stop_words = stop_words.join.gsub("\n", " ").split
  words.each_with_index { |word, index| words[index] = word.match(/\w+/).to_s }
  words = words - stop_words
  words.each { |word| common_word.include?(word) ? common_word[word] += 1 : common_word[word] = 1 }
  common_word = common_word.sort_by { |_, count| -count }[0...number_of_word].to_h
end
# rubocop:enable Metrics/MethodLength

def analyze(text)
  # TODO: should analyze the text, and return the result hash with all features
  important_words = ["is", "are", "will", "have"]

  average_words = text.scan(/\w+/).count.to_f / text.scan(/(!|\.|\?)/).count
  sentences = text.split(/(!|\.|\?)/)
  paragraph_count = text.scan(/[^\r\n]+/).count

  p paragraph_count

  average_sentence = []

  sentences.each do |sentence|
    if sentence.scan(/\w+/).count.to_f.between?(average_words*0.9, average_words*1.1) && sentence.include?("is")
      average_sentence.append(sentence.strip)
    end
  end

  return average_sentence
end
