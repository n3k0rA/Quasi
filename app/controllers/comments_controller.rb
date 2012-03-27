class CommentsController < ApplicationController

  before_filter :require_user, :only => [:create, :destroy]
  
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.banned = false
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.event, notice: I18n.t(:comments_create) }
        format.json { render json: @comment.event, status: :created, location: @comment.event }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.event.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.event }
      format.json { head :ok }
    end
  end
end
