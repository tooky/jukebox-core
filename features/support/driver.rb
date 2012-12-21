module WeddingJukebox
  module Driver
    def jukebox
      @jukebox ||= Jukebox.new(ui, catalogue)
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

      def displaying_no_results_notification?
        @results.empty?
      end
    end

  end
end
World(WeddingJukebox::Driver)
