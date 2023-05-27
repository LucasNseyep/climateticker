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

  # return {
  #   character_count: text.scan(/./).count,
  #   character_count_excluding_spaces: text.scan(/[^\s]/).count,
  #   line_count: text.scan(/^/).count,
  #   word_count: text.scan(/\w+/).count,
  #   sentence_count: text.scan(/(!|\.|\?)/).count,
  #   paragraph_count: text.scan(/[^\r\n]+/).count,
  #   average_words_per_sentence: text.scan(/\w+/).count.to_f / text.scan(/(!|\.|\?)/).count,
  #   average_sentences_per_paragraph: text.scan(/(!|\.|\?)/).count.to_f / text.scan(/[^\r\n]+/).count
  # }
end
