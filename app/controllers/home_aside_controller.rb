class HomeAsideController < ApplicationController
  def index
    @spots = Spot.order(created_at: :desc)
    render partial: 'home/aside'
  end
end
