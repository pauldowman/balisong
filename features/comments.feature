Feature: Comments
  In order to provide feedback on a post
  as a visitor
  I can comment on posts (just a link to Twitter or email for now)


  Scenario: Posts (pages with date in the id) show comment section
    Given the following pages:
      | title   | body                      | id                  | categories                        |
      | Whiskey | A page with no date       | 2010-02-01-whiskey  | alcohol, bourbon, scotch, whiskey |
    And The GitModel database is indexed
    When I go to the path "/2010/02/01/whiskey"
    Then I should see "Comments" within "div#comments"

  Scenario: Pages with no date in the id don't show comment section
    Given the following pages:
      | title   | body                      | id                | categories          |
      | Whiskey | A page with no date       | whiskey           | alcohol, bourbon, scotch, whiskey |
    And The GitModel database is indexed
    When I go to the path "/whiskey"
    Then I should not see "Comments"
