Feature: Investigating options

  Background: I ask Google Maps for directions from Philadelphia to San Fransisco
    Given I am on Google Maps
    And I input Philadelphia as my starting point and San Fransisco as my destination
    Then directions should appear on screen

  Scenario: Avoiding highways while driving
    Given I am using driving directions

  Scenario: Avoiding tolls while driving
    Given I am using driving directions

  Scenario: Avoiding ferries while driving
    Given I am using walking directions

  Scenario: Switching from miles to kilometers
    Given I am using driving directions