class AssigneesController < ApplicationController
  protect_from_forgery except: :new
  before_action :set_assignee, only: [:show, :edit, :update, :destroy]
  before_action :set_assignee_id, only: [:notes, :admin, :photos, :videos]
  before_action :set_type


  def index
    # @assignees = Assignee.all
    @assignees = policy_scope(Assignee)
  end

  def show
    @user = User.where('id = ?', params[:user_id]).first
    authorize @assignee
  end

  def new
    @assignee = Assignee.new
    if params[:format] != 'Guardian'
      @assignee.address_line_1 = @user.address_line_1
      @assignee.address_line_2 = @user.address_line_2
      @assignee.city = @user.city
      @assignee.postcode = @user.postcode
      @assignee.country = @user.country
    end

    authorize @assignee
  end

  def create
    @assignee = current_user.assignees.build(assignee_params)
    authorize @assignee
    if @assignee.save
      respond_to do |format|
        format.js
        format.html {
          if @assignee.type == 'Guardian'
            redirect_to user_guardians_path(current_user), notice: 'Assignee was successfully created.'
          elsif @assignee.relationship == 'Partner'
            redirect_to user_profile_path(current_user)
          else
            redirect_to user_children_path(current_user), notice: 'Assignee was successfully created.'
          end
          }
      end
    else
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @assignee
  end

  def update
    authorize @assignee
    if @assignee.update(assignee_params)
      if @assignee.type == 'Guardian'
        redirect_to user_guardians_path(current_user), notice: 'Assignee was successfully updated.'
      elsif @assignee.relationship == 'Partner'
        redirect_to user_profile_path(current_user)
      else
        redirect_to user_children_path(current_user), notice: 'Assignee was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    authorize @assignee
    if @assignee.type == 'Guardian'
      @assignee.destroy
      redirect_to user_guardians_path(current_user)
    else
      @assignee.destroy
      redirect_to user_children_path(current_user)
    end
  end

  def notes
    @note = Note.new
  end

  def admin
  end

  def photos
  end

  def videos
  end

  private

  def set_assignee
    @assignee = Assignee.find(params[:id])
  end

  def set_assignee_id
    @assignee = Assignee.find(params[:assignee_id] || params[:guardian_id] || params[:recipient_id])
  end

  def set_type
    if params[:type]
      @type = params[:type]
    elsif params[:format]
      @type = params[:format]
    end
  end

  def type
    params[:type]
  end

  def assignee_params
    params.require(type ? type.downcase.to_sym : :assignee).permit(:title, :first_name,
      :middle_name, :last_name, :citizenship, :date_of_birth, :email, :phone_number,
      :address_line_1, :address_line_2, :city, :country, :postcode, :relationship,
      :profile_picture, :type)
  end
end
