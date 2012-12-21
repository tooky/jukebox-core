require 'virtus'
module WeddingJukebox
  class Song
    include Virtus::ValueObject
    attribute :artist, String
    attribute :title,  String

    def matches?(term)
      title =~ /#{term}/
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


  class FakeCatalogue
    def search(term)
      @songs.select do |song|
        song.matches?(term)
      end
    end

    def add_song(song)
      songs << song
      self
    end

    def songs
      @songs ||= []
    end
  end

  module TestDataBuilder
    def create_song(song_details)
      Song.new(song_details)
    end
  end
end
