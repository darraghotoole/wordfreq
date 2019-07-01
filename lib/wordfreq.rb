require "wordfreq/normalizer"
require "wordfreq/version"
require "wordfreq/wikipedia_client"
require "wordfreq/wikipedia_page"
require "wordfreq/word_counter"

module Wordfreq
  class Wordfreq
    class << self
      def print_word_frequencies(page_id, n)
        wikipedia_client = WikipediaClient.new
        page = wikipedia_client.extract(page_id)

        normalizer = Normalizer.new
        words = normalizer.normalize(page.text)

        word_counter = WordCounter.new
        frequency_entries = word_counter.frequency(words, n)

        puts <<~HERE
          URL: 
          #{page.url}

          Title: #{page.title}

          Top 5 words:

          #{frequency_entries.map { |e| "- #{e.to_s}\n" }.join("\n")}
        HERE
      end
    end
  end
end
