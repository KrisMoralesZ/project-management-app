class CommentsController < ApplicationController
  before_action :set_artifact

  def create
    @project = Project.find(params[:project_id])
    @artifact = Artifact.find(params[:artifact_id])
    @comment = @artifact.comments.build(comment_params)
    @comment.user = current_user_with_fallback

    if @comment.save
      redirect_to project_artifact_path(@project, @artifact), notice: "Comment was successfully created."
    else
      flash[:alert] = "Comment was not saved."
      @comments = @artifact.comments.includes(:user)
      render "artifacts/show", status: :unprocessable_entity
    end
  end

  private
  def set_artifact
    @artifact = Artifact.find(params[:artifact_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :artifact_id, :project_id)
  end
end
