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
      
  Scenario: Masks work with negative letters
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "-O" into the form
    And I fill in the mask "*C*" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | ACT  | 6     |
      | CAT  | 6     |
      | TAC  | 6     |
      | TAT  | 3     |
      
  Scenario: Stars represent an infinite number of spaces
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "QWERTYUIOPASDFGHJKLZXCVBNM" into the form
    And I fill in the mask "G*" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | GOT  | 5     |
      | GO   | 4     |
      
    
  Scenario: Case insensitive
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "QWERTYUIOPASDFGHJKLZXCVBNM" into the form
    And I fill in the mask "g*" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | GOT  | 5     |
      | GO   | 4     |
      
  Scenario: Random Characters are ignored
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "CATFAP TI" into the form
    And I fill in the mask "-I?||$$^&&&&&" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | IT   | 2     |
      | I    | 1     |
      
  Scenario: You can make some spaces none optional
    Given I have loaded the dictionary
    When I visit the homepage
    And I fill in the letters "CATFAP I" into the form
    And I fill in the mask "G?!" into the form
    And search for words
    Then I should see the following words:
      | Word | Score |
      | GOT  | 5     |
