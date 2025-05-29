class ApplicationController < ActionController::Base
  set_current_tenant_through_filter

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_organization, unless: :devise_controller_for_organization_registration?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :last_name ])
  end

  private
  def set_current_organization
    if organization_signed_in? || user_signed_in?
      organization = Organization.find_by(subdomain: request.subdomain)
      ActsAsTenant.current_tenant = organization
    else
      ActsAsTenant.current_tenant = nil
    end
  end

  def devise_controller_for_organization_registration?
    devise_controller? && controller_path == "organizations/registrations"
  end
end
