Feature: Agify API

  Scenario: User to be able to get age prediction for a valid name 
    Given the agify.io API is available
    When I send a request with the name "eniya"
    Then the response status should be 200
    And the response should include the name "eniya"
    And the response should include an age 
    And the response should include a count greater than 0

  Scenario: User should not be able to get age when nam is alphanumeric
    Given the agify.io API is available
    When I send a request with the name "Eniya@123"
    Then the response status should be 200
    And the response should include the name "Eniya@123"
    And the response should include an age prediction of null
    And the response should include a count of 0

  Scenario: User should not be able to get age when name is not a string
    Given the agify.io API is available
    When I send a request with the name "3344!!"
    Then the response status should be 200
    And the response should include the name "3344!!"
    And the response should include an age prediction of null
    And the response should include a count of 0

    Scenario: User should be able to see error message when name is not provided
    Given the agify.io API is available
    When I send a request with the name ""
    And the response should include an age prediction of null
    And the response should include a count of 0

    Scenario: User should not  be able to see age prediction when name is not in database
    Given the agify.io API is available
    When I send a request with the name "Eniyyy"
    Then the response status should be 200
    And the response should include an age prediction of null
    And the response should include a count of 0

     
    Scenario: User should be able to get age prediction for a batch of 10 names
    Given the agify.io API is available
    When I send a request with the batch of names "[\"Annie\", \"Jerry\", \"Mickey\", \"Tom\", \"Jane\", \"Emily\", \"Chris\", \"John\", \"eniya\", \"stuart\"]"
    Then the response status should be 200
    And the response should include an array of results
    And each result should include "name", "age", and "count" fields
    
    Scenario: User should be able to get age prediction for a batch of more than 10 names
    Given the agify.io API is available
    When I send a request with the batch of names "[\"Annie\", \"Jerry\", \"Mickey\", \"Tom\", \"Jane\", \"Emily\", \"eniya\", \"stuart\", \"jeeva\", \"sirpi\", \"divya\", \"manoj\"]"
    Then the response status should be 422
    And the response should include an error message "Invalid 'name' parameter"
@batch
    Scenario: User should get error message on incorrect url
    Given I send an incorrect url
    Then the response status should be 422
    And the response should include an error message "Missing 'name' parameter"



