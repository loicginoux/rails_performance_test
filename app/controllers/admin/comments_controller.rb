class Admin::CommentsController < ApplicationController
  cache_sweeper :comment_sweeper
  # GET /comments
  # GET /comments.json
  # def index
  #   @comments = Comment.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @comments }
  #   end
  # end



  # def edit
  #   @comment = Comment.find(params[:id])
  # end



  def update
    @comment = Comment.find(params[:id])
    opinion = params[:comment][:opinion]
    result = @comment.update_attributes(:opinion => opinion, :is_moderated => (opinion != ""))
    respond_to do |format|
      if result
        format.html { redirect_to [:admin, @comment.article], notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @article], notice: 'Comment was successfully Destroyed.' }
      format.json { head :no_content }
    end
  end
end
