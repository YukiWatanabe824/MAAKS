class HomeAsideController < ApplicationController
  def index
    @spots = Spot.order(created_at: :desc)
    @my_spots = @spots.where("user_id = #{current_user.id}") if user_signed_in?
    render partial: 'home/aside'
  end
end
