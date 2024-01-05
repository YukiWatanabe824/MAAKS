# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def redirect_if_different_user
    return if current_user.admin?

    redirect_to root_path if current_user != User.find(params[:id])
  end

  def check_signed_out_session
    return unless session[:logged_out]

    @signed_out = true
    session.delete(:logged_out)
  end

  def check_first_access_session
    return unless session[:first_access].nil?

    @first_access = true
    session[:first_access] = true
  end
end
