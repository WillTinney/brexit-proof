class SessionsController < Devise::SessionsController

  # Devise standard controller methods
  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   yield resource if block_given?
  #   respond_with(resource, serialize_options(resource))
  # end

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end

  # Working non-AJAX login
  # def create
  #  resource = warden.authenticate!(:scope => resource_name, :recall => "pages#home")
  #  return sign_in_and_redirect(resource_name, resource)
  # end

  # def sign_in_and_redirect(resource_or_scope, resource=nil)
  #  scope = Devise::Mapping.find_scope!(resource_or_scope)
  #  resource ||= resource_or_scope
  #  sign_in(scope, resource) unless warden.user(scope) == resource
  #  return render :json => {:success => true, :redirect => after_sign_in_path_for(resource)}
  # end

  # def failure
  #   return render :json => {:success => false, :errors => ["Login failed."]}
  # end

  # Working AJAX login
  # def create
  #   resource = warden.authenticate!(:scope => resource_name, :recall => "home#index")
  #   sign_in_without_redirect(resource_name, resource)
  #   @after_sign_in_path = after_sign_in_path_for(resource)
  # end

  # def sign_in_without_redirect(resource_or_scope, resource=nil)
  #   scope = Devise::Mapping.find_scope!(resource_or_scope)
  #   resource ||= resource_or_scope
  #   sign_in(scope, resource) unless warden.user(scope) == resource
  # end



  # def create
  #   resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
  #   sign_in(resource_name, resource)
  #   # redirect_to user_profile_path(current_user)
  #   # return render :json => {:success => true, :content => render_to_string(:layout => false, :partial => 'pages/new_session')}
  # end

  # def failure
  #   return render :json => {:success => false, :errors => ["Login failed."]}
  # end
    # resource = User.find_for_database_authentication(email: params[:user][:email])
    # return invalid_login_attempt unless resource

    # if resource.valid_password?(params[:user][:password])
    #   sign_in :user, resource
    #   # return render nothing: true
    #   return redirect_to user_profile_path(current_user)
    # end

    # binding.pry

    # invalid_login_attempt
   # end

  protected

  # def invalid_login_attempt
  #   set_flash_message(:alert, :invalid)
  #   # devise_error_messages!
  #   render json: flash[:alert], status: 401
  # end

  def after_sign_in_path_for(resource)
    user_profile_path(current_user)
  end

end
