Feature: Identify
    In order to using application
    I want to create user without any service

    Scenario: Sign up
        Given I am on the front page
        When I follow "Create an account"
        Then I should see "New Account"
        When I fill "Name" with "john"
        And I fill "Email" with "john@doe.com"
        And I fill "Password" with "qwerty"
        And I fill "Password confirmation" with "qwerty"
        And I press "Register"
        Then I should see "Signed in!"

    Scenario: Login
        Given I have 1 user registered
        When I am on the front page
        And I fill "Email" with "jane@doe.com"
        And I fill "Password" with "qwerty"
        And I press "Login"
        Then I should see "Signed in!"

    Scenario: Logout
        Given I am logged user
#        When I follow "Log out"
#        Then I should see "Signed out!"