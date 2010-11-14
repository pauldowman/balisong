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
    When I go to the path "/category/Rye"
    Then I should see the following list of links with css id "pages":
      | Scotch | /2010/10/01/scotch |
      | Rye    | /rye               |

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
      | Scotch  | /2010/10/01/scotch   |
      | Bourbon | /2010/08/01/bourbon  |
      | Rye     | /rye                 |


  Scenario: List all posts in a date range
    Given the following pages:
      | title   | body                      | id                 |
      | Bourbon | A blog post about Bourbon | 2010-08-01-bourbon |
      | Rye     | A blog post about Rye     | 2010-08-11-rye     |
      | Malt    | A blog post about Malt    | 2009-10-01-malt    |
      | Scotch  | A blog post about Scotch  | 2010-10-01-scotch  |
      | Rye     | Something about Rye       | rye                |
    When I go to the path "/2010"
    Then I should see the following list of links with css id "pages":
      | Scotch  | /2010/10/01/scotch   |
      | Rye     | /2010/08/11/rye      |
      | Bourbon | /2010/08/01/bourbon  |

    When I go to the path "/2010/08"
    Then I should see the following list of links with css id "pages":
      | Rye     | /2010/08/11/rye      |
      | Bourbon | /2010/08/01/bourbon  |

    When I go to the path "/2010/08/11"
    Then I should see the following list of links with css id "pages":
      | Rye     | /2010/08/11/rye      |

    When I go to the path "/2009/10/01"
    Then I should see the following list of links with css id "pages":
      | Malt   | /2009/10/01/malt      |


