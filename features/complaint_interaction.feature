Feature: Users can advocate a complaint or relinquish it

  Background:
    Given 'Chad' is enrolled
    And   'John' is enrolled
    Given 'Chad complaint' was written
    And   'John complaint' was written
    And   'Brad' is enrolled

  Scenario: User advocates a complaint
    When  'Brad' signs in 
    And   User visits 'complaints'
    And   'Brad' advocates 'Chad complaint'
    Then  'Chad complaint' contains 'Brad' as advocator

