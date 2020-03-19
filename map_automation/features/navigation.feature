Feature: Google Map Navigation

  Background: I ask Google Maps for directions from Philidelpha to San Fransisco
    Given I am on Google Maps
    And I input Philidelphia and San Fransisco as my starting point and destination
    Then directions should appear on screen

  Scenario: Click click click
    Given I am using driving directions
    When I click the details button
    Then I can see the direction details section
    And I can click on arrows to see more specifics

