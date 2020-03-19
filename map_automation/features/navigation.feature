Feature: Google Map Navigation

  Background: I ask Google Maps for directions from Philidelpha to San Fransisco
    Given I am on Google Maps
    And I input Philidelphia and San Fransisco as my starting point and destination
    Then directions should appear on screen

  Scenario: Click click click
    Given hello
