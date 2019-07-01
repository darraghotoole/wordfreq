module Wordfreq
  class WikipediaPage
    attr_reader :url, :title, :text 

    def initialize(url, title, text)
      @url = url
      @title = title
      @text = text
    end
  end
end
