# frozen_string_literal: true

class AvatarsController < UsersController
  before_action :authenticate_user!
  before_action :redirect_if_different_user
  before_action :set_user, only: %i[destroy]

  def destroy
    @user.avatar.purge if @user.avatar.attached?
    respond_to do |format|
      if @user.avatar.attached?
        format.html { render :show, status: :unprocessable_entity }
      else
        format.html { redirect_to "/users/#{@user.id}/edit", notice: '画像は削除されました' }
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
