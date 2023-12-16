# frozen_string_literal: true

class Admins::UsersController < Admins::ApplicationController
  def index
    @user = current_user
    @pagy, @users = pagy(User.includes(avatar_attachment: :blob), items: 50)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admins_users_path, notice: t('controller.updated') }
      else
        format.html do
          redirect_to edit_admins_user_path(@user), status: :unprocessable_entity, alert: t('controller.failed_to_updated')
        end
      end
    end
  end

  def destroy
    user = User.find(params[:id])

    respond_to do |format|
      if user.destroy
        format.html { redirect_to admins_users_path, notice: t('controller.user_was_successfully_destroyed'), status: :see_other }
      else
        format.html { redirect_to admins_users_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :avatar
    )
  end
end
