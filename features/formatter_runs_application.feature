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

