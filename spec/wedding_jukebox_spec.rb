require 'wedding_jukebox/core'
require 'vcr'

RSpec.configure do |config|
  config.include TestDataBuilder
  config.extend VCR::RSpec::Macros
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end

shared_examples_for 'a catalogue' do
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

describe FakeCatalogue do
  let(:catalogue) { FakeCatalogue.new }
  before { catalogue.add_song song }

  it_behaves_like 'a catalogue'
end

describe SpotifyCatalogue do
  let(:catalogue) { SpotifyCatalogue.new }
  use_vcr_cassette "spotify api"

  it_behaves_like 'a catalogue'
end

describe SpotifyCatalogue::SongBuilder do
  let(:data) do
    {
      "name"=>"We Are Never Ever Getting Back Together",
      "artists"=> [{"name"=>"Taylor Swift"}],
    }
  end

  it "turns a piece of Spotify API data into a Song" do
    SpotifyCatalogue::SongBuilder.new(data).song.should ==
      create_song(artist: 'Taylor Swift', title: 'We Are Never Ever Getting Back Together')
  end
end
