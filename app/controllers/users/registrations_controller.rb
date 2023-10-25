# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: %i[update destroy] # rubocop:disable all
  before_action :redirect_if_different_user, only: %i[update destroy] # rubocop:disable all
  before_action :set_user, only: %i[update edit]
  before_action :configure_account_update_params, only: [:update]
  before_action :configure_sign_up_params, only: [:create] # rubocop:disable all

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

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
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
end
