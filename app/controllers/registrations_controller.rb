class RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  protected

  # Redirect to personal details page
  def after_sign_up_path_for(resource)
    user_after_sign_up_path(@user, :basic_profile)
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
