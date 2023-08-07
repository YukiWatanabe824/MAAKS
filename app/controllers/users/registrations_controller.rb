# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: %i[show edit update destroy avatar_destroy]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def edit; end

  def update_resource(resource, params)
    return super if params['password'].present?

    resource.update_without_password(params.except('current_password'))
  end

  def create
    @user = User.new(sign_up_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  def avatar_destroy
    @user.avatar.purge if @user.avatar.attached?
    respond_to do |format|
      if @user.avatar.attached?
        format.html { render :show, status: :unprocessable_entity }
      else
        format.html { redirect_to edit_user_path(current_user), notice: '画像は削除されました' }
      end
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar current_password])
  end
end
