require 'wedding_jukebox'
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
    @catalogue ||= FakeCatalogue.new
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

end
World(Driver)
