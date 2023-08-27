# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :redirect_if_different_user, only: %i[show]
  before_action :set_user, only: %i[show]

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def redirect_if_different_user
    redirect_to root_path if current_user != User.find(params[:id])
  end
end
