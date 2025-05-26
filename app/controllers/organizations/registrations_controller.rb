class Organizations::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)

    if resource.save
      ActsAsTenant.with_tenant(resource) do
        User.create!(
          email: resource.email,
          password: params[:organization][:password],
          )
      end

      redirect_to root_url(subdomain: resource.subdomain), allow_other_host: true, notice: "Organization created successfully."
      sign_up(resource_name, resource)

    else
      clean_up_passwords resource
      set_minimum_password_length

      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "form",
            partial: "organizations/errors",
            locals: { resource: resource }
          )
        end
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [ :organization_name, :subdomain ]
    )
  end
end
