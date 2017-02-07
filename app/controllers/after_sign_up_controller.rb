class AfterSignUpController < ApplicationController
  include Wicked::Wizard

  steps :sign_up, :basic_profile, :contact_info, :partner, :children, :guardians

  def show
    @user = current_user
    authorize @user

    sign_in(@user, bypass: true)
    render_wizard
  end

  def update
    @user = current_user
    authorize @user

    case step
      when :partner
        @user.partner = true if params[:commit] == "Yes"
        @user.save
        render_wizard @user
      when :children
        @user.number_of_children = params[:commit].to_i
        @user.save
        render_wizard @user
      when :guardians
        @user.number_of_guardians = params[:commit].to_i
        @user.save
        render_wizard @user
      else
        @user.update_attributes(user_params)
        sign_in(@user, bypass: true)
        render_wizard @user
    end
  end

  def partner_basic
    @assignee = Assignee.new
  end

  def finish_wizard_path
    user_profile_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :title, :first_name, :middle_name, :last_name,
      :citizenship, :date_of_birth, :phone_number, :gender,
      :address_line_1, :address_line_2, :city, :country, :postcode,
      :latitude, :longitude, :profile_picture)
  end

  def type
    params[:type] || @assignee.type
  end
end
