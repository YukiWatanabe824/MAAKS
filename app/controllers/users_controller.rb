# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_if_different_user, only: %i[show]
  before_action :set_user, only: %i[show destroy]

  def show; end

  def destroy
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
end
