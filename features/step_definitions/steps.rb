Given /^the following song exists in the Jukebox's catalogue$/ do |table|
  @song = create_song(table.hashes.first)
  catalogue.add_song @song
end

When /^I search for "(.*?)"$/ do |search_term|
  jukebox.search(search_term)
end

Then /^I should see the song in the results$/ do
  ui.should be_displaying_result(@song)
end

module Driver
  def jukebox
    @jukebox ||= Jukebox.new(ui, catalogue)
  end

  def create_song(song_details)
    Song.new(song_details)
  end

  def ui
    @ui ||= TestUI.new
  end

  def catalogue
    @catalogue ||= TestCatalogue.new
  end

  class TestUI

    def displaying_result?(song)
      @results.include?(song)
    end

    def display_search_results(results)
      @results = results
      self
    end
  end

  class TestCatalogue
    def add_song(song)
      songs << song
      self
    end

    def songs
      @songs ||= []
    end

    def search(term)
      @songs
    end
  end
end
World(Driver)

class Song
  def initialize(details)
    @artist = details.fetch('artist')
    @title = details.fetch('title')
  end
end

class Jukebox
  def initialize(ui, catalogue)
    @ui, @catalogue = ui, catalogue
  end

  def search(term)
    @ui.display_search_results @catalogue.search(term)
    self
  end
end
