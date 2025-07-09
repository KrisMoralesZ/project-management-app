class Organizations::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    set_flash_message!(:notice, :signed_in)
    sign_in_user_for_organization(resource)

    redirect_to root_url(subdomain: resource.subdomain, host: "localhost", protocol: "http"), allow_other_host: true
  end

  def destroy
    signed_out = sign_out(resource_name)
    signed_out(:user) if signed_out.nil?
    set_flash_message! :notice, :signed_out if signed_out

    redirect_to root_url(subdomain: nil, host: "localhost", protocol: "http"), allow_other_host: true
  end

  private

  def sign_in_user_for_organization(organization)
    owner = organization.owner
    sign_in(:user, owner) if owner.present? && !user_signed_in?
  end
end
