Feature: Home page
  In order to easily find and discover the site's content
  as a visitor
  I see a homepage with an overview of what's available on the site.

  Scenario: Display recent posts ordered with most recent first.
    Given the following pages:
      | title   | body                      | id                 | categories            |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey |                       |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  |                       |
      | Rye     | A blog post about Rye     | 2010-10-01-rye     |                       |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see the following post previews:
      | title   | path                | content                   |
      | Rye     | /2010/10/01/rye     | A blog post about Rye     |
      | Scotch  | /2010/09/01/scotch  | Something about Scotch    |
      | Whiskey | /2010/08/01/whiskey | A blog post about Whiskey |

  Scenario: Don't display pages without dates in recent posts.
    Given the following pages:
      | title   | body                      | id                 | categories            |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey |                       |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  |                       |
      | Rye     | A page (no date in id)    | rye                |                       |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see the following post previews:
      | title   | path                | content                   |
      | Scotch  | /2010/09/01/scotch  | Something about Scotch    |
      | Whiskey | /2010/08/01/whiskey | A blog post about Whiskey |

