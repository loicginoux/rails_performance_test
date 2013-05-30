Given(/^I am on the articles page$/) do
	visit articles_path()
end

Then "I am on the article page" do
   current_path.should == article_path(Article.last)
end

