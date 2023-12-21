Feature: petstore user API Test

  Background:
    * url baseURL

  Scenario: Create a new user
    Given path 'user'
    And request { "id": 1, "username": "willypratama", "firstName": "Willy", "lastName": "Pratama", "email": "willypratama31.wp@gmail.com", "password": "digitalskola", "phone": "123456789", "userStatus": 1 }
    When method POST
    Then status 200

  Scenario: Get user by username
    Given path 'user/willypratama'
    When method GET
    Then status 200
    And match response == { "id": 1, "username": "willypratama", "firstName": "Willy", "lastName": "Pratama", "email": "willypratama31.wp@gmail.com", "password": "digitalskola", "phone": "123456789", "userStatus": 1 }

  Scenario: Log in user
    Given path 'user/login'
    And request { "username": "willypratama", "password": "digitalskola" }
    When method GET
    Then status 200

  Scenario: Log out current logged in user session
    Given path 'user/logout'
    When method GET
    Then status 200
    And match response == { "code": 200, "type": "unknown", "message": "ok" }

  Scenario: Delete user
    Given path 'user/willypratama'
    When method DELETE
    Then status 200

  Scenario: Verify user deletion
    Given path 'user/willypratama'
    When method GET
    Then status 404
    And match response == { "code": 1, "type": "error", "message": "User not found" }
