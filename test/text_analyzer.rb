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
end
