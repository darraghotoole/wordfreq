module Wordfreq
  class WordCounter
    # Given an array of words, calculate the frequency of each word and returns an ordered
    # list of n WorkFrequency objects representing the highest frequency values and the words 
    # which appear at that fequency.
    def frequency(words, n)
      frequencies = Hash.new(0)
      words.each do |w| 
        frequencies[w] += 1
      end

      sorted_words = frequencies.keys.sort { |a,b| frequencies[b] <=> frequencies[a] }

      results = WordFrequencyResults.new(n)
      
      until sorted_words.empty?
        word = sorted_words.shift
        frequency = frequencies[word]

        break unless results.add_word(word, frequency)
      end
     
      results.entries
    end

    # Helper class for collating words with shared frequencies
    class WordFrequencyResults
      attr_reader :entries

      def initialize(n)
        @entries = []
        @n = n
      end

      # Returns true if the word has been added to the results. Returns false if 
      # the results object is full
      def add_word(word, frequency)
        return add_new_entry(word, frequency) if entries.empty?
        return append_word(word) if frequency == entries.last.frequency
        add_new_entry(word, frequency)
      end

      private def add_new_entry(word, frequency)
        return false if @entries.size == @n

        entry = WordFrequencyEntry.new(frequency)
        entry.add(word)
        @entries << entry
        true
      end

      private def append_word(word)
        @entries.last.add(word)
        true
      end
    end

    class WordFrequencyEntry
      attr_reader :frequency, :words

      def initialize(frequency)
        @frequency = frequency
        @words = []
      end

      def add(word)
        @words << word
      end

      def to_s
        "#{frequency} #{words.sort.join(", ")}"
      end
    end
  end
end
