@javascript
Feature: Creating an article
  In order to add articles
  As a basic user
  I want to create articles

Scenario: Creating an article
  Given I am on the articles page
  When I click on "New Article"
  And I set "my title" in "#article_title"
  And I set "my article content" in "#article_content"
  And I click on "Create Article"
  Then I am on the article page
  And I see the message "Article was successfully created."
  Given I am on the articles page
  Then I see the article with title "my title" in the articles table

