class Admin::CommentsController < Admin::AdminController


  
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to admin_event_path(@comment.event), notice: 'Comment was successfully created.' }
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
      format.html { redirect_to admin_event_path(@comment.event) }
      format.json { head :ok }
    end
  end
  
  def ban_comment
    @comment = Comment.find(params[:id])
    @comment.banned =true;
    @comment.save
    redirect_to admin_event_path(@comment.event)
  end
end
