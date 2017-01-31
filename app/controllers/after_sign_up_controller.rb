class AfterSignUpController < ApplicationController
  include Wicked::Wizard

  steps :sign_up, :basic_profile, :contact_info, :partner, :partner_basic, :partner_contact, :children, :child_basic, :child_contact, :guardians, :guardian_basic, :guardian_contact, :complete

  def show
    @user = current_user
    # @assignee = @user.assignees.new
    # binding.pry
    authorize @user

    case step
      when :partner_basic
        @assignee = @user.assignees.new
      when :partner_contact
        @assignee = @user.partner
      when :child_basic
        skip_step if @user.number_of_children == 0
        @assignee = @user.assignees.new
      when :child_contact
        skip_step if @user.number_of_children == 0
        @assignee = @user.children.last
      when :guardian_basic
        @assignee = @user.assignees.new
      when :guardian_contact
        @assignee = @user.guardians.last
    end
    sign_in(@user, bypass: true)
    render_wizard
  end

  def update
    @user = current_user
    authorize @user

    case step
      when :partner_basic
        @assignee = @user.assignees.new
        @assignee.update_attributes(assignee_params)
        sign_in(@user, bypass: true)
        render_wizard @assignee
      when :partner_contact
        @assignee = @user.partner
        @assignee.update_attributes(assignee_params)
        sign_in(@user, bypass: true)
        render_wizard @assignee
      when :children
          @user.number_of_children = params[:commit].to_i
          @user.save
          render_wizard @user
      when :child_basic
        @assignee = @user.assignees.new
        @assignee.update_attributes(assignee_params)
        sign_in(@user, bypass: true)
        render_wizard @assignee
      when :child_contact
        @assignee = @user.children.last
        sign_in(@user, bypass: true)
        @assignee.update_attributes(assignee_params)
        binding.pry
        if @user.children.count < @user.number_of_children
          redirect_to wizard_path(:child_basic)
        else
          render_wizard @assignee
        end
      when :guardian_basic
        @assignee = @user.assignees.new
        @assignee.update_attributes(assignee_params)
        sign_in(@user, bypass: true)
        render_wizard @assignee
      when :guardian_contact
        @assignee = @user.guardians.last
        @assignee.update_attributes(assignee_params)
        sign_in(@user, bypass: true)
        render_wizard @assignee
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
    user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :middle_name, :last_name,
      :citizenship, :date_of_birth, :phone_number, :gender,
      :address_line_1, :address_line_2, :town, :country, :postcode,
      :latitude, :longitude, :profile_picture)
  end

  def type
    params[:type] || @assignee.type
  end

  def assignee_params
    params.require(type ? type.downcase.to_sym : :assignee).permit(:first_name,
      :middle_name, :last_name, :citizenship, :date_of_birth, :email, :phone_number,
      :address_line_1, :address_line_2, :town, :country, :postcode, :relationship,
      :profile_picture, :type)
  end
end
