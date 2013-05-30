class ArticlesController < ApplicationController
  cache_sweeper :article_sweeper
  # GET /articles
  # GET /articles.json
  def index
    # @articles = Article.select([:id, :title]).recent.limit(10).all
    @articles = Rails.cache.fetch("articles/last_10") do
      Article.select([:id, :title]).recent.limit(10).all
    end

    # @count = Article.count
    @count = Rails.cache.fetch("articles/count") do
      Article.count
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    id = params[:id]
    @article = Rails.cache.fetch("article/#{id}") do
      Article.find(id)
    end

    @comments = Rails.cache.fetch("article/#{id}/comments/moderated/true/last_20") do
      Comment.from_article(id).recent.moderated.limit(20).all
    end

    @countComments = Rails.cache.fetch("article/#{id}/comments/moderated/true/count") do
      Comment.from_article(id).moderated.count
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # # GET /articles/1/edit
  # def edit
  #   @article = Article.find(params[:id])
  # end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    id = params[:id]
    @article = Rails.cache.fetch("article/#{id}") do
      Article.find(id)
    end
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
