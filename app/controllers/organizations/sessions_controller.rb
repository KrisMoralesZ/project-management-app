class Organizations::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  def create
    self.resource = warden.authenticate!(auth_options)

    redirect_to root_url(subdomain: resource.subdomain, host: "localhost", protocol: "http"), allow_other_host: true

    sign_in(resource_name, resource)
    set_flash_message!(:notice, :signed_in)
  end

  def destroy
    signed_out = sign_out(resource_name)
    set_flash_message! :notice, :signed_out if signed_out

    redirect_to root_url(subdomain: nil, host: "localhost", protocol: "http"), allow_other_host: true
  end
end
