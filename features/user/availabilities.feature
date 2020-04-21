Feature:
    In order to fill in my availabilities,
    As a user,
    I must be able to create my account.

    Scenario: As anonymous, I cannot go to user planning
        When I go to "/user/availability"
        Then I should be on "/login"
        And the response status code should be 200

    Scenario: As authenticated user, I can navigate through the planning weeks
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/"
        When I follow "Mes disponibilités pour la semaine prochaine"
        Then the url should match "/user/availability"
        And the response status code should be 200
        When I follow "Semaine actuelle"
        Then the url should match "/user/availability"
        And the response status code should be 200

    Scenario Outline: As authenticated user, I cannot add an availability on a booked/locked slot
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/"
        When I follow "Mes disponibilités pour la semaine prochaine"
        Then the url should match "/user/availability"
        And the response status code should be 200
        And the "<time>" availability checkbox should not exists
        Examples:
            | time                  |
            | next week monday 2 am |
            | next week monday 4 am |
            | next week monday 6 am |
            | next week monday 8 am |

    Scenario Outline: As authenticated user, I can add and remove an availability at any free slot in the future
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/"
        When I follow "Mes disponibilités pour la semaine prochaine"
        Then the url should match "/user/availability"
        And the response status code should be 200
        When I check "<time>" availability checkbox
        And I press "Enregistrer mes disponibilités"
        Then I should be on "/"
        And the response status code should be 200
        And I should see "Vos disponibilités ont été mises à jour avec succès."
        Then I follow "Mes disponibilités pour la semaine prochaine"
        And the url should match "/user/availability"
        And the response status code should be 200
        And the availability checkbox "<time>" should be checked
        When I uncheck "<time>" availability checkbox
        And I press "Enregistrer mes disponibilités"
        Then I should be on "/"
        And the response status code should be 200
        And I should see "Vos disponibilités ont été mises à jour avec succès."
        Then I follow "Mes disponibilités pour la semaine prochaine"
        And the url should match "/user/availability"
        And the response status code should be 200
        And the availability checkbox "<time>" should be unchecked
        Examples:
            | time                      |
            | next week monday 1 pm     |
            | next week tuesday 10 am   |
            | next week wednesday 12 pm |
            | next week thursday 2pm    |
            | next week friday 4pm      |
            | next week saturday 6pm    |
            | next week sunday 8pm      |
            | next week sunday 10pm     |

    Scenario Outline: As authenticated user, I can remove an availability at any available slot in the future
        Given I am authenticated as "jane.doe@resop.com"
        And I am on "/"
        When I follow "Mes disponibilités pour la semaine prochaine"
        Then the url should match "/user/availability"
        And the response status code should be 200
        When I uncheck "<time>" availability checkbox
        And I press "Enregistrer mes disponibilités"
        Then I should be on "/"
        And the response status code should be 200
        And I should see "Vos disponibilités ont été mises à jour avec succès."
        Then I follow "Mes disponibilités pour la semaine prochaine"
        And the url should match "/user/availability"
        And the response status code should be 200
        And the availability checkbox "<time>" should be unchecked
        Examples:
            | time                   |
            | next week monday 12 am |
