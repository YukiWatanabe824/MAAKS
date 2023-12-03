# frozen_string_literal: true

class Admin::AvatarsController < Admin::ApplicationController
  before_action :set_user, only: %i[destroy]

  def destroy
    @user.avatar.purge if @user.avatar.attached?
    respond_to do |format|
      if @user.avatar.attached?
        format.html { render :show, status: :unprocessable_entity, alert: t('controller.failed_to_deleted') }
      else
        format.html { redirect_to edit_admin_user_path(@user), notice: t('controller.deleted') }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
