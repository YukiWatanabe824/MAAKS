# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :redirect_if_different_user, only: %i[show]
  before_action :set_user, only: %i[show destroy]

  def index
    redirect_to root_path, alert: t('controller.you_do_not_have_administrative_privileges') if !current_user.admin?

    @user = current_user
    @pagy, @users = pagy(User.includes(avatar_attachment: :blob), items: 50)
  end

  def show; end

  def destroy
    authenticate_admin

    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_path, notice: t('controller.user_was_successfully_destroyed'), status: :see_other } if current_user.admin?
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

  def redirect_if_different_user
    return if current_user.admin?

    redirect_to root_path if current_user != User.find(params[:id])
  end

  def authenticate_admin(user = @user)
    return if current_user == user

    redirect_to root_path, alert: t('controller.you_do_not_have_administrative_privileges') if !current_user.admin?
  end
end
