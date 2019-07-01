RSpec.describe Wordfreq::Normalizer do
  let(:normalizer) { Wordfreq::Normalizer.new }

  it "returns an array of words" do
    words = normalizer.normalize("fizz buzz fizz buzz")
    expect(words).to eq(["fizz", "buzz", "fizz", "buzz"])
  end

  it "drops words shorter than 4 characters long" do
    words = normalizer.normalize("fizz buzz foo bar")
    expect(words).to eq(["fizz", "buzz"])
  end

  it "strips non alphabetic characters" do
    words = normalizer.normalize("asd* foobar! ab123 fizzbuzz")
    expect(words).to eq(["foobar", "fizzbuzz"])
  end

  it "handles multiline input" do
    words = normalizer.normalize("here's a sentence with\n\nnewlines")
    expect(words).to eq(["here", "sentence", "with", "newlines"])
  end

  it "handles whitespace" do
    words = normalizer.normalize("lots of   \t\t\n\n       whitespace")
    expect(words).to eq(["lots", "whitespace"])
  end

  it "downcases content" do
    words = normalizer.normalize("word WORD Word")
    expect(words).to eq(["word", "word", "word"])
  end
end
