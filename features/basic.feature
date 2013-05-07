Feature: Basic words that can be made from these letters search
  In order to cheat at scrabble
  As a bad scrabble player
  I want to be able to get all of the words that can be made from some scrabble letters
  
  Scenario: Words in the dictionary are returned if they're able to be made from the letters in the tiles
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "CAT" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | ACT  | 6     |
      | CAT  | 6     |
      | TAC  | 6     |

  Scenario: Words in the dictionary are returned if they're able to be made from the letters in the tiles and we can use blanks
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters " AT" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | ACT  | 6     |
      | CAT  | 6     |
      | FAT  | 6     |
      | TAC  | 6     |
      | TAT  | 3     |
