require 'wedding_jukebox'

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }
  let(:song) { Song.new(artist: 'David Bowie', title: 'We could be heroes') }
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
