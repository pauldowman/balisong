Feature: Home page
  In order to easily find and discover the site's content
  as a visitor
  I see a homepage with an overview of what's available on the site.

  Scenario: Display list of recent posts ordered with most recent first.
    Given the following pages:
      | title   | body                      | id                 | categories            |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey |                       |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  |                       |
      | Rye     | A blog post about Rye     | 2010-10-01-rye     |                       |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see the following list of links with css id "recent_posts":
      | Rye     | /2010/10/01/rye     |
      | Scotch  | /2010/09/01/scotch  |
      | Whiskey | /2010/08/01/whiskey |

  Scenario: Don't display pages without dates in list of recent posts.
    Given the following pages:
      | title   | body                      | id                 | categories            |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey |                       |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  |                       |
      | Rye     | A page (no date in id)    | rye                |                       |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see the following list of links with css id "recent_posts":
      | Scotch  | /2010/09/01/scotch  |
      | Whiskey | /2010/08/01/whiskey |

  Scenario: Display a list of all categories on home page.
    Given the following pages:
      | title   | body                      | id                 | categories              |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey | Whiskey, Alcohol        |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  | Scotch, Alcohol         |
      | Rye     | A blog post about Rye     | 2010-10-01-rye     | Rye, Alcohol, Malt |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see the following list of links with css id "all_categories":
      | Alcohol | /category/Alcohol   |
      | Malt    | /category/Malt      |
      | Rye     | /category/Rye       |
      | Scotch  | /category/Scotch    |
      | Whiskey | /category/Whiskey   |


