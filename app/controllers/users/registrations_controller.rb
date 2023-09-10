# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, except: %i[new create build_resource configure_sign_up_params]
  before_action :redirect_if_different_user, except: %i[new create build_resource configure_sign_up_params]
  before_action :set_user, only: %i[update avatar_destroy edit]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def edit; end

  def update
    if current_user.admin?
      update_resource_by_admin
    else
      super
    end
  end

  def update_resource_by_admin
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update_resource(resource, params)
    return super if params['password'].present?

    resource.update_without_password(params.except('current_password'))
  end

  def create
    @user = User.new(sign_up_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
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

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to root_path, notice: 'User was successfully destroyed.', status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
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

  def redirect_if_different_user
    return if current_user.admin?

    redirect_to root_path if current_user != User.find(params[:id])
  end
end
