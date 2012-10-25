Given /^the following song exists in the Jukebox's catalogue$/ do |table|
  @song = Song.new(table.hashes.first)
  jukebox.add_song(@song)
end

When /^I search for "(.*?)"$/ do |search_term|
  jukebox.search(search_term)
end

Then /^I should see the song in the results$/ do
  ui.results.should include(@song)
end

module Driver
  def jukebox
    @jukebox ||= Jukebox.new(ui)
  end

  def ui
    @ui ||= TestUI.new
  end

  class TestUI
    def results
      []
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
  def initialize(ui)

  end

  def add_song(song)

  end

  def search(term)
  end
end
