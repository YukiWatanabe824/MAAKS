# frozen_string_literal: true

class AvatarsController < UsersController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :redirect_if_different_user, only: %i[destroy]
  before_action :set_user, only: %i[destroy]

  def destroy
    @user.avatar.purge if @user.avatar.attached?
    respond_to do |format|
      if @user.avatar.attached?
        format.html { render :show, status: :unprocessable_entity, alert: t('controller.failed_to_deleted') }
      else
        format.html { redirect_to "/users/#{@user.id}/edit", notice: t('controller.deleted') }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def redirect_if_different_user
    return if current_user.admin?

    redirect_to root_path if current_user != User.find(params[:id])
  end
end
