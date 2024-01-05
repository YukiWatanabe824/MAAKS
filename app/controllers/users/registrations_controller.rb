# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_different_user, only: %i[update destroy] # rubocop:disable all
  before_action :configure_account_update_params, only: [:update] # rubocop:disable all
  before_action :configure_sign_up_params, only: [:create] # rubocop:disable all

  def new
    @user = User.new
  end

  def edit; end

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

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar current_password])
  end
end
