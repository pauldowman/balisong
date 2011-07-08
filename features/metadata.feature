Feature: Site and page metadata
  In order to easily promote and index the site's content
  as a web crawling bot
  I see page metadata

  Scenario: Feed autodiscovery link
    Given the following pages:
      | title   | body                      | id                 | categories            |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey |                       |
    And The GitModel database is indexed
    When I go to the homepage
    Then I should see a valid Atom feed autodiscovery tag

