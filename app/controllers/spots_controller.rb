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
    @spot = current_user.admin? ? Spot.find(params[:id]) : current_user.spot.find(params[:id])
    render partial: 'edit_form', locals: { spot: @spot, user: @user }
  end

  def create
    @spot = current_user.spots.new(spot_params)
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
      :title, :accident_type, :contents, :accident_date, :longitude, :latitude
    )
  end

  def generate_500_error
    raise StandardError unless turbo_frame_request?
  end
end
