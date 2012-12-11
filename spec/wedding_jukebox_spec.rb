require 'wedding_jukebox'

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }

  context "searching for songs" do
    it "returns exact matching songs" do
      song = Song.new('artist' => 'David Bowie', 'title' => 'Heroes')
      catalogue.add_song song
      catalogue.search('Heroes').should == [song]
    end

    it "returns partial matching songs" do
      song = Song.new('artist' => 'David Bowie', 'title' => 'We could be heroes')
      catalogue.add_song song
      catalogue.search('heroes').should == [song]
    end

    it "does not include songs that don't match" do
      song = Song.new('artist' => 'David Bowie', 'title' => 'Heroes')
      catalogue.add_song song
      catalogue.search('Villains').should_not include(song)
    end
  end

end
