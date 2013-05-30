class ArticleObserver < ActiveRecord::Observer
	observe :article
	def after_destroy(article)
    # we delete his comments in a background task
    commentIds = article.comments.pluck(:id)
    statIds = article.stats_article_comments.pluck(:id)
    Comment.delay.destroy(commentIds)
    StatsArticleComment.delay.destroy(statIds)
  end
end
