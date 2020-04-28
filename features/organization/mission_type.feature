Feature:
    In order to manage my mission types,
    As an organization,
    I must be able to list, edit and delete mission types.

    Scenario: As anonymous, I cannot list mission types from an organization
        When I go to "/organizations/mission_type/new"
        Then I should be on "/organizations/login"
        And the response status code should be 200

    Scenario: As an organization, I can list my mission types
        Given I am authenticated as "DT75"
        And I am on "/organizations"
        When I follow "Modifier les types de missions"
        Then I should be on "/organizations/mission_type/"
        And the response status code should be 200
        And I should see "Mission type DT75 1"
        And I should see "Mission type DT75 2"
        And I should not see "Mission type DT77 1"
        And I should not see "Mission type DT77 2"

    # todo: test collection type with javascript
    Scenario: As an organization, I can create a mission type
        Given I am authenticated as "DT75"
        And I am on "/organizations/mission_type/"
        When I follow "Ajouter un nouveau type de mission"
        Then I should be on "/organizations/mission_type/new"
        And the response status code should be 200
        When I fill in the following:
            | mission_type[name]                  | mission type name |
            | mission_type[minimumAvailableHours] | 2                 |
        And I press "Enregistrer"
        Then the response status code should be 200
        And I should be on "/organizations/mission_type/"
        And I should see "mission type name"

    Scenario: As an organization, I can edit a mission type
        Given I am authenticated as "DT75"
        And I am on "/organizations/mission_type/"
        When I follow "Modifier"
        Then the response status code should be 200
        And I should be on "/organizations/mission_type/751/edit"
        When I fill in the following:
            | mission_type[name]                             | mission type name |
            | mission_type[userSkillsRequirement][0][skill]  | ci_bspp           |
        And I press "Enregistrer"
        Then the response status code should be 200
        And I should be on "/organizations/mission_type/"
        And I should see "mission type name"
        When I follow "Modifier"
        And I should see "CI Réseau BSPP"

    Scenario: As an organization, I cannot edit a mission type of another organization
        Given I am authenticated as "DT75"
        And I am on "/organizations/mission_type/771/edit"
        Then the response status code should be 403

#    @javascript
#    Scenario: As an organization, I can delete a mission type
#        Given I am authenticated as "DT75"
#        And I am on "/organizations/mission_type/"
#        When I press "Supprimer"
#        Then I should see "Vous êtes sur le point de supprimer le type de mission : Mission type DT75 1"
#        When I press "Supprimer"
#        Then the response status code should be 200
#        And I should be on "/organizations/mission_type/"
#        And I should not see "Le type de mission a été supprimé avec succès "
#        And I should not see "Mission type DT75 1"

    Scenario: As an organization, I cannot delete a mission type of another organization
        Given I am authenticated as "DT75"
        And I am on "/organizations/mission_type/771/delete"
        Then the response status code should be 403

