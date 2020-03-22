Feature: Investigating Options

  Background: I ask Google Maps for directions from Philadelphia to San Fransisco
    Given I am on Google Maps
    And I input Philadelphia as my starting point and San Fransisco as my destination
    Then directions should appear on screen

  Scenario: Avoiding highways while driving
    Given I am using driving directions
    And highways are a part of the initial directions
    When I click avoid highways from the direction options
    Then the direction details will not include highways

  Scenario: Avoiding tolls while driving
    Given I am using driving directions
    And tolls are a part of the initial directions
    When I click avoid tolls from the direction options
    Then the direction details will not include tolls

  Scenario: Avoiding ferries while biking
    Given I am using biking directions
    And ferries are a part of the initial directions
    When I click avoid ferries from the direction options
    Then the direction details will not include ferries

  Scenario: Switching from miles to kilometers
    Given I am using driving directions
    When I switch to distance in kilometers
    Then kilometers will show up in the directions
    When I switch to distance in miles
    Then miles will show up in the directions
