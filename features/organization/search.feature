Feature:
    In order to find a user or an asset,
    As an admin of an organization,
    I must be able to search users and assets.

    Scenario: As anonymous, I cannot go to the search page
        When I go to "/organizations/1/search?query=foo"
        Then I should be on "/login"
        And the response status code should be 200

    Scenario: As an admin of a parent organization, I can search for a volunteer even in my children organizations
        Given I am authenticated as "john.doe@resop.com"
        And I am on "/organizations/1"
        When I fill in "query" with " jAnE dOe reSOp "
        And I press "Rechercher"
        Then I should be on "/organizations/1/search"
        And the response status code should be 200
        And I should see "Rechercher \"jAnE dOe reSOp\""
        And I should see "990002A"
        And I should see "jane.doe@resop.com"
        And I should see "Aucun véhicule ne correspond à votre recherche."

    Scenario: As an admin of a children organization, I can search for a volunteer in my organization
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/organizations/3"
        When I fill in "query" with " jAnE dOe reSOp "
        And I press "Rechercher"
        Then I should be on "/organizations/3/search"
        And the response status code should be 200
        And I should see "Rechercher \"jAnE dOe reSOp\""
        And I should see "990002A"
        And I should see "jane.doe@resop.com"
        And I should see "Aucun véhicule ne correspond à votre recherche."

    Scenario: As an admin of an organization, I cannot search for a user in another organization
        Given I am authenticated as "john.doe@resop.com"
        And I am on "/organizations/1"
        When I fill in "query" with " cHuCk nOrRiS reSOp "
        And I press "Rechercher"
        Then I should be on "/organizations/3/search"
        And the response status code should be 200
        And I should see "Rechercher \"cHuCk nOrRiS reSOp\""
        And I should see "Aucun bénévole ne correspond à votre recherche."
        And I should see "Aucun véhicule ne correspond à votre recherche."

    Scenario Outline: As an admin of a parent organization, I can search for an asset even in my children
        Given I am authenticated as "john.doe@resop.com"
        And I am on "/organizations/1"
        When I fill in "query" with " <search> "
        And I press "Rechercher"
        Then I should be on "/organizations/1/search"
        And the response status code should be 200
        And I should see "Rechercher \"<search>\""
        And I should see "<name>"
        And I should see "Aucun bénévole ne correspond à votre recherche."
        Examples:
            | search | name         |
            | 75992  | VPSP - 75992 |
            | 75012  | VPSP - 75012 |

    Scenario: As an admin of a children organization, I can search for an asset in my organization
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/organizations/3"
        When I fill in "query" with " 75012 "
        And I press "Rechercher"
        Then I should be on "/organizations/3/search"
        And the response status code should be 200
        And I should see "Rechercher \"75012\""
        And I should see "VPSP - 75012"
        And I should see "Aucun bénévole ne correspond à votre recherche."

    Scenario: As an admin of an organization, I cannot search for an asset in another organization
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/organizations/3"
        When I fill in "query" with " 77282 "
        And I press "Rechercher"
        Then I should be on "/organizations/3/search"
        And the response status code should be 200
        And I should see "Rechercher \"77282\""
        And I should see "Aucun bénévole ne correspond à votre recherche."
        And I should see "Aucun véhicule ne correspond à votre recherche."
