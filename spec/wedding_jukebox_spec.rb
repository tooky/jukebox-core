require 'wedding_jukebox'

Rspec.configure do |config|
  config.include TestDataBuilder
end

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }
  let(:song) { create_song(artist: 'David Bowie', title: 'We could be heroes') }
  before { catalogue.add_song song }

  context "searching for songs" do
    it "returns exact matching songs" do
      catalogue.search('We could be heroes').should == [song]
    end

    it "returns partial matching songs" do
      catalogue.search('heroes').should == [song]
    end

    it "does not include songs that don't match" do
      catalogue.search('Villains').should_not include(song)
    end
  end

end

require 'json'
class SpotifyCatalogue
  def search(term)
    results = JSON.parse(`curl http://ws.spotify.com/search/1/track.json?q=#{term}`)
    SongBuilder.map(results)
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

#describe SpotifyCatalogue do
  #let(:catalogue) { SpotifyCatalogue.new }
  #let(:song) { create_song(artist: 'David Bowie', title: 'We could be heroes') }

  #context "searching for songs" do
    #it "returns exact matching songs" do
      #catalogue.search('We could be heroes').should == [song]
    #end

    #it "returns partial matching songs" do
      #catalogue.search('heroes').should == [song]
    #end

    #it "does not include songs that don't match" do
      #catalogue.search('Villains').should_not include(song)
    #end
  #end
#end
