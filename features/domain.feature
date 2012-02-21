Feature: Domain
    In order to using application
    I want to manage my domain

    Scenario: Search domain
        Given I am logged in
        And I have 3 domains
        When I follow "Domains"
        Then I should see "Listing domains"
        And I should see "google.com"
        And I should see "facebook.com"
        And I should see "twitter.com"
        When I fill "keyword" with "oo"
        And I press "Search"
        And I should see "google.com"
        And I should see "facebook.com"
        And I should not see "twitter.com"

    Scenario: Sort domain
        Given I am logged in
        And I have 3 domains
        When I follow "Domains"
        Then I should see domains "google.com", "facebook.com", "twitter.com"
        When I follow "Domain"
        Then I should see domains "facebook.com", "google.com", "twitter.com"
        When I follow "Domain"
        Then I should see domains "twitter.com", "google.com", "facebook.com"
