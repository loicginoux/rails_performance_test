class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

  has_many :comments
  has_many :stats_article_comments

	scope :recent, order("created_at DESC")
end
