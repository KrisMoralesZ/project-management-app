class DashboardController < ApplicationController
  def index
    @organization_users = current_organization.users
  end
end
