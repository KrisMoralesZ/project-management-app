class Users::InvitationsController < Devise::InvitationsController
  def create
    user = User.invite!(
      {
        email: params[:user][:email],
        name: params[:user][:name],
        role: params[:user][:role]
      },
      current_user
    )

    if user.errors.empty?
      redirect_to dashboard_path, notice: "User has been invited."
    else
      redirect_to dashboard_path, alert: "Something went grong, please try again."
    end
  end

  protected
  def after_accept_path_for(resource)
    user_session_path(resource)
  end
end
