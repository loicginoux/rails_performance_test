class Admin::StatsArticleCommentsController < ApplicationController

	def index
		id = params[:article_id]

    @stats = StatsArticleComment.recent
      .for_article(id)
      .paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats }
    end
  end
end
