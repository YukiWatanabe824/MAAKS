# frozen_string_literal: true

class HomeAsideController < ApplicationController
  def index
    @spots_pagy, @spots = pagy(Spot.order(created_at: :desc))
    @my_spots_pagy, @my_spots = pagy(Spot.order(created_at: :desc).where("user_id = #{current_user.id}")) if user_signed_in?

    render partial: 'home/aside'
  end
end
