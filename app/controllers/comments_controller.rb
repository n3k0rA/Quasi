class CommentsController < ApplicationController

  before_filter :require_user, :only => [:create, :destroy]
  before_filter :deletable_comment, :only=> [:destroy]
  after_filter :create_micropost, :only=>[:create]
  

  # Creates and saves a new comment
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @user= current_user
    @content = "commented"
    @object = @comment.event.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.event, notice: I18n.t(:comments_create) }
        format.json { render json: @comment.event, status: :created, location: @comment.event }
      else
        format.html { redirect_to  @comment.event, notice: "Comment body cannot be blank" }
        format.json { render json: @comment.event.errors, status: :unprocessable_entity }
      end
    end
  end

 


  # Deletes a comment
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.event }
      format.json { head :ok }
    end
  end
  
  # Sends an email to the administrator with the comment as flagged
  def report_spam
    @comment = Comment.find(params[:id])
    AdminMailer.report_spam(@comment).deliver
    flash[:notice] = "The comment has been notified to the admins"
    redirect_to @comment.event
  end

private
  # Checks whether a comment has been posted more than 5 min ago
  def deletable_comment
    @comment = Comment.find(params[:id])
    if Time.now > (@comment.created_at + 5.minutes)
      flash[:notice] = "This comment is already in memory system and cannot be deleted"
      redirect_to @comment.event
      return false
    end
  end
  
end
