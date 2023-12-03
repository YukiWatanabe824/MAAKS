# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController
  def index
    @user = current_user
    @pagy, @users = pagy(User.includes(avatar_attachment: :blob), items: 50)
  end

  def destroy
    user = User.find(params[:id])

    respond_to do |format|
      if user.destroy
        format.html { redirect_to admin_users_path, notice: t('controller.user_was_successfully_destroyed'), status: :see_other }
      else
        format.html { redirect_to admin_users_path, status: :unprocessable_entity }
      end
    end
  end

end
