require 'wedding_jukebox'

RSpec.configure do |config|
  config.include TestDataBuilder
end

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }
  let(:song) { create_song(artist: 'The Libertines', title: 'What Became Of The Likely Lads') }
  before { catalogue.add_song song }

  context "searching for songs" do
    it "returns exact matching songs" do
      catalogue.search('What Became Of The Likely Lads').should include(song)
    end

    it "returns partial matching songs" do
      catalogue.search('Likely').should include(song)
    end

    it "does not include songs that don't match" do
      catalogue.search('Villains').should_not include(song)
    end
  end

end

require 'json'
require 'rest_client'
class SpotifyCatalogue
  def search(term)
    results = JSON.parse(query_api(term))
    SongBuilder.map(results)
  end

  def query_api(term)
    RestClient.get("http://ws.spotify.com/search/1/track.json", params: {q: term})
  end

  class SongBuilder
    def self.map(data)
      data['tracks'].map { |data| new(data).song }
    end

    def initialize(data)
      @data = data
    end

    def title
      @data["name"]
    end

    def artist
      @data["artists"].first["name"]
    end

    def song
      Song.new title: title, artist: artist
    end
  end
end

describe SpotifyCatalogue::SongBuilder do
  let(:data) do
    {
      "name"=>"We Are Never Ever Getting Back Together",
      "artists"=> [{"name"=>"Taylor Swift"}],
    }
  end

  it "turns a piece of Spotify API data into a Song" do
    SpotifyCatalogue::SongBuilder.new(data).song.should == Song.new(artist: 'Taylor Swift', title: 'We Are Never Ever Getting Back Together')
  end
end

describe SpotifyCatalogue do
  let(:catalogue) { SpotifyCatalogue.new }
  let(:song) { create_song(artist: 'The Libertines', title: 'What Became Of The Likely Lads') }

  context "searching for songs" do
    it "returns exact matching songs" do
      catalogue.search('What Became Of The Likely Lads').should include(song)
    end

    it "returns partial matching songs" do
      catalogue.search('Likely').should include(song)
    end

    it "does not include songs that don't match" do
      catalogue.search('Villains').should_not include(song)
    end
  end

end
