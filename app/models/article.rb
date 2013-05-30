class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

  has_many :comments, :dependent => :destroy
  has_many :stats_article_comments, :dependent => :destroy

	scope :recent, order("created_at DESC")
end
