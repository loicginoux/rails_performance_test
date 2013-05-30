# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'factory_girl_rails'
require 'faker'


nbArticle = 10
nbCommentsPerArticle = 1000

nbArticle.times do |n|
	# a = FactoryGirl.create :article
	# create article with comments
	FactoryGirl.create(:article_with_comments, comments_count: nbCommentsPerArticle)

end