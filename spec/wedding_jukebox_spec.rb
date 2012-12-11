require 'wedding_jukebox'

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }

  context "searching for songs" do
    it "returns matching songs" do
      song = Song.new('artist' => 'David Bowie', 'title' => 'Heroes')
      catalogue.add_song song
      catalogue.search('Heroes').should == [song]
    end
  end

end
