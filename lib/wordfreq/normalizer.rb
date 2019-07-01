module Wordfreq
  class Normalizer 
    MIN_WORD_SIZE = 4
    def normalize(text)
      alphabetic_text = text.gsub(/[^A-Za-z]/, " ")
      words = alphabetic_text.downcase.split(" ")
      words.reject { |w| w.size < MIN_WORD_SIZE}
    end
  end
end
