class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    organization = Organization.create(
      organization_name: params[:user][:organization_name],
      subdomain: params[:user][:subdomain]
    )
    resource.organization = organization

    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)

        redirect_to root_url(subdomain: organization.subdomain, host: "localhost", protocol: "http"), allow_other_host: true
      else
        expire_data_after_sign_in!
        redirect_to root_url(subdomain: organization.subdomain, host: "localhost", protocol: "http"), allow_other_host: true
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
