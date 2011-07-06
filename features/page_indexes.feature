Feature: Page indexes
  In order to easily find and discover the site's content
  as a visitor
  I can see lists of the pages and posts by category and date

  Scenario: List all pages in a category
    Given the following pages:
      | title   | body                      | id                | categories                                 |
      | Bourbon | A blog post about Bourbon | 2010-08-01-bourbon| Bourbon, Alcohol                           |
      | Scotch  | A blog post about Scotch  | 2010-10-01-scotch | Scotch, Bourbon, Rye, Bourbon rye, Alcohol |
      | Rye     | Something about Rye       | rye               | Rye, Alcohol                               |
    And The GitModel database is indexed
    When I go to the path "/category/Rye"
    Then I should see the following list of links with css id "pages":
      | Rye    | /rye               |
      | Scotch | /2010/10/01/scotch |

    When I go to the path "/category/Bourbon"
    Then I should see the following list of links with css id "pages":
      | Scotch  | /2010/10/01/scotch  |
      | Bourbon | /2010/08/01/bourbon |

    When I go to the path "/category/Scotch"
    Then I should see the following list of links with css id "pages":
      | Scotch  | /2010/10/01/scotch   |

    When I go to the path "/category/Bourbon%20rye"
    Then I should see the following list of links with css id "pages":
      | Scotch  | /2010/10/01/scotch   |

    When I go to the path "/category/Alcohol"
    Then I should see the following list of links with css id "pages":
      | Rye     | /rye                 |
      | Scotch  | /2010/10/01/scotch   |
      | Bourbon | /2010/08/01/bourbon  |


  Scenario: List all posts in a date range
    Given the following pages:
      | title   | body                      | id                 | categories |
      | Bourbon | A blog post about Bourbon | 2010-08-01-bourbon |            |
      | Rye     | A blog post about Rye     | 2010-08-11-rye     |            |
      | Malt    | A blog post about Malt    | 2009-10-01-malt    |            |
      | Scotch  | A blog post about Scotch  | 2010-10-01-scotch  |            |
      | Rye     | Something about Rye       | rye                |            |
    And The GitModel database is indexed
    When I go to the path "/2010"
    Then I should see the following list of links with css id "pages":
      | Scotch  | /2010/10/01/scotch  |
      | Rye     | /2010/08/11/rye     |
      | Bourbon | /2010/08/01/bourbon |

    When I go to the path "/2010/08"
    Then I should see the following list of links with css id "pages":
      | Rye     | /2010/08/11/rye     |
      | Bourbon | /2010/08/01/bourbon |

    When I go to the path "/2010/08/11"
    Then I should see the following list of links with css id "pages":
      | Rye   | /2010/08/11/rye |

    When I go to the path "/2009/10/01"
    Then I should see the following list of links with css id "pages":
      | Malt   | /2009/10/01/malt      |


  Scenario: Display a list of all categories
    Given the following pages:
      | title   | body                      | id                 | categories              |
      | Whiskey | A blog post about Whiskey | 2010-08-01-whiskey | Whiskey, Alcohol        |
      | Scotch  | Something about Scotch    | 2010-09-01-scotch  | Scotch, Alcohol         |
      | Rye     | A blog post about Rye     | 2010-10-01-rye     | Rye, Alcohol, Malt |
    And The GitModel database is indexed
    When I go to the path "/category/Whiskey"
    Then I should see the following list of links with css id "all-categories":
      | Alcohol | /category/Alcohol |
      | Malt    | /category/Malt    |
      | Rye     | /category/Rye     |
      | Scotch  | /category/Scotch  |
      | Whiskey | /category/Whiskey |

