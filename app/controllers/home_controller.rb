# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_mapbox, only: %i[index]

  def index
    @user = User.find(current_user.id) if current_user
    @spots_pagy, @spots = pagy(Spot.order(created_at: :desc).limit(50))
    @my_spots_pagy, @my_spots = pagy(current_user.spots.order(created_at: :desc)) if user_signed_in?

    check_first_access_session
  end

  private

  def set_mapbox
    @mapbox_access_token = Rails.application.credentials.mapbox.access_token
    @mapbox_style = Rails.application.credentials.mapbox.style
  end
end
