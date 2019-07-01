RSpec.describe Wordfreq::WikipediaClient do
  let(:page_id) { 123 }
  let(:client) { Wordfreq::WikipediaClient.new }

  let(:response) { instance_double(HTTParty::Response, body: response_body, success?: success) }
  let(:success) { true }
  let(:response_body) do
    <<~HERE
    {
      "batchcomplete": "",
      "query": {
        "pages": {
          "123": {
            "pageid": 123,
            "ns": 0,
            "title": "Some page",
            "extract": "Here's some text from the extract."
          }
        }
      }
    }
    HERE
  end

  before do 
    allow(HTTParty).to receive(:get).and_return(response)
  end

  it "GETs the wikipedia page" do
    expected_url = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&pageids=123&explaintext&format=json"
    expect(HTTParty).to receive(:get).with(expected_url)
    client.extract(page_id)
  end

  it "returns a page object" do
    page = client.extract(page_id)
    expect(page).to be_a(Wordfreq::WikipediaPage)
    expect(page.text).to eq("Here's some text from the extract.")
  end

  context "when the page is not found" do
    let(:response_body) do
      <<~HERE
        {
          "batchcomplete":"",
          "query": {
            "pages": {
              "123": {
                "pageid":123,
                "missing":""
              }
            }
          }
        }
      HERE
    end

    it "raises an error" do
      expect{ client.extract(page_id) }.to raise_error("page does not exist")
    end
  end

  context "when the request is not successful" do
    let(:success) { false }

    it "raises an error" do
      expect { client.extract(page_id) }.to raise_error("could not retrieve page")
    end
  end
end
