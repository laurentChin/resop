Feature:
    In order to manage my children organizations,
    As an admin of a parent organization,
    I must be able to list, edit and create them.

    Scenario: As anonymous, I cannot list the children of an organization
        When I go to "/organizations/1/children"
        Then I should be on "/login"
        And the response status code should be 200

    Scenario: As an admin of a parent organization, I can list the children of my organization
        Given I am authenticated as "john.doe@resop.com"
        When I go to "/organizations/1"
        Then I should see "Modifier mes structures"
        When I follow "Modifier mes structures"
        Then I should be on "/organizations/1/children"
        And the response status code should be 200
        And I should see "UL 01-02"

    Scenario: As an admin of an organization without children, I cannot list the children of my organization
        Given I am authenticated as "jane.doe@resop.com"
        When I go to "/organizations/3"
        Then I should not see "Modifier mes structures"
        When I go to "/organizations/3/children"
        And the response status code should be 404

    Scenario: As an admin of an organization but without a password, I cannot list the children of my organization
        Given I am authenticated as "jane.doe@resop.com"
        When I go to "/organizations/3/children"
        Then the response status code should be 403

    Scenario Outline: As an admin of an organization, I cannot list the children of another organization
        Given I am authenticated as "john.doe@resop.com"
        When I go to "<url>"
        Then the response status code should be 403
        Examples:
            | url                       |
            | /organizations/2/children |
            | /organizations/3/children |
            | /organizations/4/children |

    Scenario: As anonymous, I cannot create an organization
        When I go to "/organizations/1/new"
        Then I should be on "/login"
        And the response status code should be 200

    Scenario: As an admin of a parent organization, I can create an organization
        Given I am authenticated as "john.doe@resop.com"
        And I am on "/organizations/1/children"
        When I follow "Ajouter une structure"
        Then I should be on "/organizations/1/new"
        And the response status code should be 200
        When I fill in the following:
            | organization[name] | Lorem ipsum |
        And I press "Valider"
        Then I should be on "/organizations/1/children"
        And the response status code should be 200
        And I should see "La structure a été ajoutée avec succès."
        And I should see "Lorem ipsum"

    Scenario: As an admin of a children organization, I cannot create an organization
        Given I am authenticated as "jane.doe@resop.com"
        When I go to "/organizations/3/new"
        Then the response status code should be 403

    Scenario: As an admin of an organization, I cannot create an organization on another one
        Given I am authenticated as "john.doe@resop.com"
        When I go to "/organizations/2/new"
        Then the response status code should be 403

    Scenario: As anonymous, I cannot update an organization
        When I go to "/organizations/1/edit"
        Then I should be on "/login"
        And the response status code should be 200

    Scenario Outline: As an admin of an organization, I cannot update my organization
        Given I am authenticated as "<login>"
        When I go to "<url>"
        Then the response status code should be 403
        Examples:
            | login              | url                   |
            | john.doe@resop.com | /organizations/1/edit |
            | jane.doe@resop.com | /organizations/3/edit |

    Scenario: As an admin of a parent organization, I can update my children organizations
        Given I am authenticated as "john.doe@resop.com"
        And I am on "/organizations/1/children"
        When I follow "Modifier"
        Then I should be on "/organizations/3/edit"
        And the response status code should be 200
        And I should see "Modifier une structure"
        When I fill in the following:
            | organization[name] | Lorem ipsum |
        And I press "Valider"
        Then I should be on "/organizations/1/children"
        And the response status code should be 200
        And I should see "La structure a été mise à jour avec succès."
        And I should see "Lorem ipsum"

    Scenario: As an admin of an organization, I cannot update another organization
        Given I am authenticated as "john.doe@resop.com"
        When I go to "/organizations/2/edit"
        Then the response status code should be 403
