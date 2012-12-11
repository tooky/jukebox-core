require 'virtus'
class Song
  include Virtus::ValueObject
  attribute :artist, String
  attribute :title,  String
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

class FakeCatalogue
  def search(term)
    @songs
  end

  def add_song(song)
    songs << song
    self
  end

  def songs
    @songs ||= []
  end
end
