class CommentObserver < ActiveRecord::Observer
  observe :comment
  def after_create(comment)
  	# create stat object
  	stat = StatsArticleComment.getDayStat(comment.article_id, comment.created_at.to_date())
    stat.createComment(comment)
  end

	def after_update(comment)
    # we update his counters
		stat = StatsArticleComment.getDayStat(comment.article_id, comment.created_at.to_date())
		stat.updateComment(comment)
  end

  def after_destroy(comment)
    # we update his counters
		stat = StatsArticleComment.getDayStat(comment.article_id, comment.created_at.to_date())
		stat.removeComment(comment)
  end
end
