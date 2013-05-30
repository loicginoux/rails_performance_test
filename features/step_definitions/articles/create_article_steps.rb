Then (/^I see the article with title "(.*?)" in the articles table$/) do |title|
  # find("table tr:last td:nth-child(2)").should have_content title
  find("table").should have_text title
end

