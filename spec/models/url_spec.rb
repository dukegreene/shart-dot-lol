require "rails_helper"

describe Url do
  let(:url){Url.new(original_url: "http://example.com", shartened: "fFpvbrRR", visits: 4)}
  let(:default_url){Url.new}

  it "has an original url" do
    expect(url.original_url).to eq("http://example.com")
  end

  it "has a strink" do
    expect(url.strink).to eq("fFpvbrRR")
  end

  it "has a shartened url" do
    expect(url.shartened_url).to eq("http://urlshartener.com/fFpvbrRR")
  end

  it "has a count of visits" do
    expect(url.visits).to be(4)
  end

  it "has a default visit count of zero" do
    expect(default_url.visits).to be(0)
  end

  describe "#sharten!" do
    let(:new_url){Url.new}

    it "sets the url's strink attribute" do
      expect{new_url.sharten!}.to change{new_url.strink.length}
    end

    it "sets a strink containing eight characters consisting entirely of upper/lowercase B, F, P, R, and V characters" do
      expect(new_url.sharten!.strink).to match(/[BFPRV]{8}/i)
    end

    it "sets a strink that was not previously saved" do
      saved_url = Url.create(original_url: "http://example.com", strink: "ffFFrrRR")
      new_url = Url.new(strink: "ffFFrrRR")
      expect(new_url.sharten!.strink).to_not eq("ffFFrrRR")
    end

  end

end