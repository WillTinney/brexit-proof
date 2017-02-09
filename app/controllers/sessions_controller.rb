class SessionsController < Devise::SessionsController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      # return render nothing: true
      return redirect_to user_profile_path(current_user)
    end

    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    # devise_error_messages!
    render json: flash[:alert], status: 401
  end

  private

  def sign_up_params
    params.require(:user).permit(:title, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:title, :first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
