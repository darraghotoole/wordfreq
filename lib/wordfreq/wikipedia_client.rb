require "httparty"
require "json"

module Wordfreq
  class WikipediaClient

    def extract(page_id)
      page_path = url(page_id)
      response = HTTParty.get(page_path)
     
      raise "could not retrieve page" unless response.success?

      json = JSON.parse(response.body)
      page = json["query"]["pages"][page_id.to_s]
      raise "page does not exist" if page["missing"]

      return WikipediaPage.new(page_path, page["title"], page["extract"] )
    end

    def url(page_id)
      "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&pageids=#{page_id}&explaintext&format=json"
    end
  end
end
