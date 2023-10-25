# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  def redirect_if_different_user
    return if current_user.admin?

    redirect_to root_path if current_user != User.find(params[:id])
  end
end
