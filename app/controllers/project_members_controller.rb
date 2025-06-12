class ProjectMembersController < ApplicationController
  before_action :set_project

  def search
    query = params[:query]

    @results = User
                 .where(organization_id: current_organization.id)
                 .where.not(id: @project.users.pluck(:id))
                 .where("email ILIKE :q OR name ILIKE :q", q: "%#{query}%")

    respond_to do |format|
      format.turbo_stream
      format.html { head :unprocessable_entity }
    end
  end

  def add
    user = User.find(params[:user_id])
    @project.users << user unless @project.users.include?(user)

    redirect_to project_path(@project), notice: "User added successfully"
  end


  private
  def set_project
    @project = Project.find(params[:project_id])
  end
end
