class CommentsController < ApplicationController
  cache_sweeper :comment_sweeper

  def create
    id = params[:comment][:article_id]

    @article = Rails.cache.fetch("article/#{id}") do
      Article.find(id)
    end

    @comment = @article.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@article, :notice => 'Comment was successfully created. Waiting for moderation...') }
      else
        format.html { redirect_to(@article, :notice =>
        'Comment could not be saved. Please fill in all fields')}

      end
    end
  end


end
