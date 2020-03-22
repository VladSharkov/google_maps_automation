Feature: Google maps direction details

  Background: I ask Google Maps for directions from Philidelpha to San Fransisco
    Given I am on Google Maps
    And I input Philadelphia as my starting point and San Fransisco as my destination
    Then directions should appear on screen

  @details @driving
  Scenario: Driving direction details
    Given I am using driving directions
    When I click the details button
    Then I can see the direction details section
    And I can click on arrows to see more specifics
    And I can click the arrows to remove the specifics

  @details @publictransport
  Scenario: Public transport direction details
    Given I am using public transport directions
    When I click through the details of various routes
    Then I will see different results

  @details @walking @biking
  Scenario Outline: Walking and biking direction details
    Given I am using <movement_type> directions
    When I click the details button
    Then I will see direction details associated with <movement_type>

    Examples:
      | movement_type |
      | walking       |
      | biking        |

