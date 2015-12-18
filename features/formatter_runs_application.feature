Feature: formatter runs application

  As a formatter
  I want to run the application
  So that I can convert Chord Pro files to PDF

  Scenario: run application with no arguments
    Given I am at the command line
    When I run the application with the arguments ""
    Then I should see usage instructions

  Scenario: run application with --help
    Given I am at the command line
    When I run the application with the arguments "--help"
    Then I should see complete instructions

  Scenario: run application with an invalid option
    Given I am at the command line
    When I run the application with the arguments "--foo"
    Then I should see "invalid option: --foo"

  Scenario: run application with a single song
    Given I am at the command line
    When I run the application with the arguments "--song data/test_songs/song1.pro"
    Then I should see "Parsing song Test Song 1"
    And 1 pdf should be generated
    And the first pdf should have 1 page

  Scenario: run application with two songs
    Given I am at the command line
    When I run the application with the arguments "--song data/test_songs/song1.pro --song data/test_songs/song2.pro"
    Then I should see "Parsing song Test Song 1"
    And I should see "Parsing song Test Song 2"
    And 2 pdfs should be generated

  Scenario: run application with a songbook definition
    Given I am at the command line
    When I run the application with the arguments "--book data/test_books/book1.songbook"
    Then I should see "Loading songbook Test Songbook 1"
