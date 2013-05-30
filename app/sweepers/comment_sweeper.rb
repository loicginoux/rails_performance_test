class CommentSweeper < ActionController::Caching::Sweeper
  observe Comment

  def after_create(comment)
    expire_cache(comment)
  end

  def after_update(comment)
    # I suppose that a comment can't be updated and changed to another article
    expire_cache(comment)
    if comment.is_moderated && !comment.is_moderated_was
      update_cache_count(comment, 1)
    elsif !comment.is_moderated && comment.is_moderated_was
      update_cache_count(comment, -1)
    end
  end

  def after_destroy(comment)
    expire_cache(comment)
    update_cache_count(comment, -1) if comment.is_moderated
  end

  private


  def expire_cache(comment)
    # we always delete this cache as we can only delete one of the last 10 comment
    # Rails.cache.delete("article/#{comment.article_id}/comments/all")
    Rails.cache.delete("article/#{comment.article_id}/comments/moderated/true/last_20")

  end

  def update_cache_count(comment, nb)
    cacheKey = "article/#{comment.article_id}/comments/moderated/true/count"
    count = Rails.cache.fetch(cacheKey)
    count = 0 if count.nil?
    Rails.cache.write(cacheKey, count + nb)
  end

end