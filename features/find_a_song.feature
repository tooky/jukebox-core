Feature: Find a song

  Scenario: Find a song
    Given the following track exists in the Jukebox's catalogue
      | artist      | title              |
      | David Bowie | We could be heroes |
    When I search for "heroes"
    Then I should see the song in the results

  Scenario: Unknown song

  Scenario: Song already in playlist

  Scenario: Lots of matching songs

  # Specs for juke box api
  #Scenario: Search by track title
  #Scenario: Search by artist name
  #Scenario: Don't show things that don't match
