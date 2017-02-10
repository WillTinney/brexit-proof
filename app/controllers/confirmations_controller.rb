class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    user_after_sign_up_path(@user, :basic_profile)
  end
end
