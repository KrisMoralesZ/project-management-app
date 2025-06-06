class WelcomeController < ApplicationController
  def index
    redirect_to dashboard_path if organization_signed_in?

    # redirect_to projects_path if user_signed_in? && current_user.role == 1
  end

  def redirect_to_subdomain
    organization = Organization.find_by(organization_name: params[:organization_name])

    if organization
      redirect_to new_organization_session_url(subdomain: organization.subdomain, host: "localhost", protocol: "http"), allow_other_host: true
    else
      redirect_to root_url, allow_other_host: true
    end
  end
end
