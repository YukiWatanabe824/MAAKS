# frozen_string_literal: true

class HomeAsideController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @spots_pagy, @spots = pagy(Spot.order(created_at: :desc))
    @my_spots_pagy, @my_spots = pagy(current_user.spots.order(created_at: :desc)) if user_signed_in?

    render partial: 'home/aside'
  end
end
