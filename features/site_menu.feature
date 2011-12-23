Feature: Site menu
  In order to navigate the site's content
  as a visitor
  I can see a site navigation menu on every page


  Scenario: 
    Given the following pages:
      | title   | body                   | id                | site_menu_position | categories |
      | Whiskey | A page about Whiskey   | whiskey           | 2                  |            |
      | Scotch  | Something about Scotch | 2010-09-01-scotch | 3                  |            |
      | Rye     | A page about Rye       | rye               |                    |            |
      | Tequila | All about Tequila      | tequila           | 1                  |            |
    And The GitModel database is indexed
    When I go to the path "/tequila"
    Then I should see the following list of links with css id "site-menu":
      | text    | url                |
      | Home    | /                  |
      | Tequila | /tequila           |
      | Whiskey | /whiskey           |
      | Scotch  | /2010/09/01/scotch |
