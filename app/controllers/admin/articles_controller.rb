class Admin::ArticlesController < ApplicationController

  def show
    id = params[:id]
    flash[:notice] = nil
    @status = (params[:comment]) ? params[:comment][:status] : ""
    @article = Rails.cache.fetch("article/#{id}") do
      Article.find(id)
    end
      # default to all comments
    if params[:commit] != "Search"
      @comments = Comment.from_article(id)
        .recent
        .paginate(:page => params[:page], :per_page => 10)
    else
      begin
        @comments = Comment.search(id, params[:from], params[:to], @status)
        .paginate(:page => params[:page], :per_page => 10)

      rescue
        flash[:notice] = "Date format incorrect in search form, YYYY-MM-DD format expected."
        @comments = []
      end
    end

    @count = @comments.count

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
end
