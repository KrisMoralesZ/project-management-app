class ProjectMembersController < ApplicationController
  before_action :set_project

  def search
    query = params[:query]
    @results = @project.organization.users
                       .where.not(id: @project.users.pluck(:id))
                       .where("email ILIKE :q OR name ILIKE :q", q: "%#{query}%")
    render :search
  end


  private
  def set_project
    @project = Project.find(params[:project_id])
  end
end
