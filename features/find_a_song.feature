Feature: Find a song

  Scenario: Find a song
    Given the following song exists in the Jukebox's catalogue
      | artist      | title              |
      | David Bowie | We could be heroes |
    When I search for "heroes"
    Then I should see the song in the results

  Scenario: Unknown song
    Given the following song exists in the Jukebox's catalogue
      | artist      | title              |
      | David Bowie | We could be heroes |
    When I search for "villains"
    Then I should not see the song in the results
    And I should be notified that my song could not be found

  Scenario: Song already in playlist

  Scenario: Lots of matching songs

  # Specs for juke box api
  #Scenario: Search by track title
  #Scenario: Search by artist name
  #Scenario: Don't show things that don't match
