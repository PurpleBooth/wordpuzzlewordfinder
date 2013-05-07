Feature: Word mask to allow you to limit word length, or add on board tiles
  In order to cheat at scrabble
  As a bad scrabble player
  I want to be able to get all of the words that can be made from some scrabble letters
  
  Scenario: You can filter words that don't match a criteria
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "CATFAP I" into the form
    And I fill in the mask "?A?" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | CAT  | 6     |
      | FAT  | 6     |
      | TAC  | 6     |
      | TAT  | 3     |
