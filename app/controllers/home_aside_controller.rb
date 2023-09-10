class HomeAsideController < ApplicationController
  def index
    render partial: 'home/aside'
  end
end
