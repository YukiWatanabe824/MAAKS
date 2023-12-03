# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_if_different_user, only: %i[show]
  before_action :set_user, only: %i[show destroy]
  before_action :authenticate_admin, only: %i[destroy]

  def show; end

  def destroy
    authenticate_admin

    respond_to do |format|
      if @user.destroy
        format.html { redirect_to root_path, notice: t('controller.user_was_successfully_destroyed'), status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_admin(user = @user)
    return if current_user == user

    raise(ActionController::RoutingError, 'Not Found') if !current_user.admin?
  end
end
