class ArtifactsController < ApplicationController
  before_action :set_project
  before_action :set_artifact, only: %i[show edit update destroy]

  def index
    @artifacts = @project.artifacts
  end

  def show; end

  def new
    @project = Project.find(params[:project_id])
    @artifact = @project.artifacts.new
    @comments = @artifact.comments.includes(:user).order(created_at: :asc)
  end

  def create
    @artifact = @project.artifacts.new(artifact_params)
    @artifact.creator = current_user_with_fallback if current_user_with_fallback.is_a?(User)



    if @artifact.save
      redirect_to [@project, @artifact], notice: "Artifact was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @artifact.update(artifact_params)
      redirect_to [@project, @artifact], notice: "Artifact was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @artifact.destroy
    redirect_to project_artifacts_path(@project), notice: "Artifact was successfully deleted."
  end

  def update_status
    @project = Project.find(params[:project_id])
    @artifact = @project.artifacts.find(params[:id])

    if @artifact.update(status: params[:status])
      redirect_to project_path(@project), notice: "Artifact was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_artifact
    @artifact = @project.artifacts.find(params[:id])
  end

  def artifact_params
    params.require(:artifact).permit(:name, :description, :assignee_id, :status)
  end
end
