# frozen_string_literal: true

class TextAnalyzer
  def analyze(text)
    important_sentences = []
    important_words = ["is", "are", "climate change", "net-zero", "net zero", "sustainability"]

    average_words = text.scan(/\w+/).count.to_f / text.scan(/(!|\.|\?)/).count
    sentences = text.split(/(!|\.|\?)/)
    paragraph_count = text.scan(/[^\r\n]+/).count
    sentences.each do |sentence|
      important_words.each do |word|
        if sentence.scan(/\w+/).count.to_f.between?(average_words * 0.7, average_words * 1.4) && sentence =~ /\b#{word}\b/
          important_sentences.append(sentence.strip)
        end
      end
    end
    important_sentences.uniq
  end

  private

  def open_file(file_name, array)
    File.open(file_name, 'r').each_line do |line|
      array.append(line)
    end
  end

  def most_common_words(file_name, stop_words_file_name, number_of_word)
    words = []
    common_word = {}
    stop_words = []
    open_file(file_name, words)
    open_file(stop_words_file_name, stop_words)
    words = words.join.gsub("\n", ' ').split
    words.map(&:downcase!)
    stop_words = stop_words.join.gsub("\n", ' ').split
    words.each_with_index { |word, index| words[index] = word.match(/\w+/).to_s }
    words -= stop_words
    words.each { |word| common_word.include?(word) ? common_word[word] += 1 : common_word[word] = 1 }
    common_word = common_word.sort_by { |_, count| -count }[0...number_of_word].to_h
  end
end
