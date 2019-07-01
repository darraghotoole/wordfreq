RSpec.describe Wordfreq::WordCounter do
  let(:n) { 3 }
  let(:counter) { Wordfreq::WordCounter.new }
  let(:words) { %w(cat dog cat dog bat cat) }
  let(:frequencies) { counter.frequency(words, n).map(&:to_s) }

  it "returns the top frequencies and associated words" do
    expect(frequencies).to eq(["3 cat", "2 dog", "1 bat"])
  end

  context "when words appear at equal frequency" do
    let(:words) { %w(cat cat cat dog dog dog rat rat bat bat) }

    it "consolidates words with equal frequency to a single entry" do
      expect(frequencies).to eq(["3 cat, dog", "2 bat, rat"])
    end
  end

  context "when the number of words exceeds n" do
    let(:n) { 2 }

    it "returns only the top n entries" do
      expect(frequencies).to eq(["3 cat", "2 dog"])
    end
  end
end
