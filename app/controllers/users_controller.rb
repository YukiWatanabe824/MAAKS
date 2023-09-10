# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :authenticate_admin!, only: %i[destroy]
  before_action :redirect_if_different_user_or_admin, only: %i[show]
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.all
    @user = current_user
  end

  def show; end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_path, notice: 'User was successfully destroyed.', status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def redirect_if_different_user_or_admin
    return if current_user.admin?
    redirect_to root_path if current_user != User.find(params[:id])
  end

  def authenticate_admin!
    redirect_to toot_path , notice: '管理権限がありません' if !current_user.admin?
  end

end
