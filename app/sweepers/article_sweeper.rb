class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article

  def after_create(article)
    expire_cache(article)
    update_cache_count(1)
  end

  def after_destroy(article)
    expire_cache(article)
    update_cache_count(-1)
  end

  private


  def expire_cache(article)
    # we always delete this cache as we can only delete one of the last 10 article
    puts "expire cache"
    #  this line makes the weird memcache sound...
    Rails.cache.delete("articles/last_10") if Rails.cache.exist?("articles/last_10")
    Rails.cache.delete("article/#{article.id}") if Rails.cache.exist?("articles/#{article.id}")
  end

  def update_cache_count(nb)
    puts "update cache counts"
    count = Rails.cache.read("articles/count")
    if count
      Rails.cache.write("articles/count", count + nb)
    else
      Rails.cache.write("articles/count", nb)
    end

  end
end