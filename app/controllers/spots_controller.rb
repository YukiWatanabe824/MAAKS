# frozen_string_literal: true

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new]
  before_action :generate_500_error, only: %i[show edit new]
  before_action :set_spot, only: %i[show]
  before_action :set_spot_by_admin_or_own, only: %i[edit update destroy]

  def index
    @spots = Spot.all
  end

  def show
    render partial: 'show'
  end

  def new
    @user = current_user
    @spot = current_user.spots.new if user_signed_in?
    render partial: 'new_form'
  end

  def edit
    @user = current_user
    render partial: 'edit_form'
  end

  def create
    @spot = current_user.spots.new(spot_params)
    @user = current_user
    respond_to do |format|
      if @spot.save
        flash.now.notice = t('controller.spot_created!')
        format.turbo_stream
        format.html { redirect_to root_path, notice: t('controller.spot_created!') }
      else
        format.html do
          render partial: 'new_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: t('controller.failed_to_create_spot')
        end
      end
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @spot.update(spot_params)
        flash.now.notice = t('controller.updated')
        format.turbo_stream
        format.html { redirect_to root_path, notice: t('controller.updated') }
      else
        format.html do
          render partial: 'edit_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: t('controller.failed_to_updated')
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @spot.destroy
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

  def set_spot_by_admin_or_own
    @spot = current_user.admin? ? set_spot : current_user.spots.find(params[:id])
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
