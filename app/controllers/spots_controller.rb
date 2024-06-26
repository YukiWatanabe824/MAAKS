# frozen_string_literal: true

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new]
  before_action :generate_500_error, only: %i[show edit new]
  before_action :set_spot, only: %i[show]

  def index
    @spots = Spot.all
  end

  def show
    render partial: 'show'
  end

  def new
    @user = current_user
    @spot = current_user.spots.new if user_signed_in?
    render partial: 'new_form', locals: { spot: @spot, user: @user }
  end

  def edit
    @user = current_user
    @spot = current_user.admin? ? Spot.find(params[:id]) : current_user.spots.find(params[:id])
    render partial: 'edit_form', locals: { spot: @spot, user: @user }
  end

  def create
    @spot = current_user.spots.new(spot_params)
    @spot.address = get_address(@spot.longitude, @spot.latitude)
    @user = current_user
    respond_to do |format|
      if @spot.save
        format.turbo_stream { flash.now[:notice] = t('controller.spot_created!') }
        format.html { redirect_to root_path, notice: t('controller.spot_created!') }
      else
        format.html do
          render partial: 'new_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: t('controller.failed_to_create_spot')
        end
      end
    end
  end

  def update
    @spot = current_user.spots.find(params[:id])
    @user = current_user
    respond_to do |format|
      if @spot.update(spot_params)
        format.turbo_stream { flash.now[:notice] = t('controller.updated') }
        format.html { redirect_to root_path, notice: t('controller.updated') }
      else
        format.html do
          render partial: 'edit_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: t('controller.failed_to_updated')
        end
      end
    end
  end

  def destroy
    @spot = current_user.spots.find(params[:id])
    respond_to do |format|
      if @spot.destroy
        set_paging
        check_first_access_session
        format.turbo_stream { flash.now[:notice] = t('controller.deleted') }
        format.html { redirect_to root_path, notice: t('controller.deleted'), status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: t('controller.failed_to_deleted') }
      end
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def set_paging
    @spots_pagy, @spots = pagy(Spot.order(created_at: :desc))
    @my_spots_pagy, @my_spots = pagy(current_user.spots.order(created_at: :desc)) if user_signed_in?
  end

  def spot_params
    params.require(:spot).permit(
      :title, :accident_type, :contents, :accident_date, :longitude, :latitude, :address, :unknown_accident_date
    )
  end

  def generate_500_error
    raise StandardError unless turbo_frame_request?
  end

  def get_address(lng, lat)
    access_token = Rails.application.credentials.mapbox.access_token

    uri = URI.parse('https://api.mapbox.com')

    http_client = Net::HTTP.new(uri.host, uri.port)
    http_client.use_ssl = true

    request = Net::HTTP::Get.new(
      "/geocoding/v5/mapbox.places/#{lng},#{lat}.json?access_token=#{access_token}",
      { 'Referer' => 'https://maaks.jp/' }
    )
    response = http_client.request(request)
    location_data = JSON.parse(response.body)

    create_address(location_data)
  end

  def create_address(location_data)
    prefecture = location_data['features'][3]['text']
    locality = location_data['features'][2]['text']
    address = location_data['features'][0]['text']

    "#{prefecture}#{locality}#{address}"
  end
end
