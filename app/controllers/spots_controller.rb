# frozen_string_literal: true

class SpotsController < ApplicationController
  before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = Spot.all
    respond_to do |format|
      format.json {render json: @spots}
      format.html
    end
  end

  def show
    render partial: 'show'
  end

  def new
    @user = current_user
    @spot = Spot.new
    render partial: 'new_form'
  end

  def edit
    @user = current_user
    render partial: 'edit_form'
  end

  def create
    @spot = Spot.new(spot_params)
    @user = current_user
    respond_to do |format|
      if @spot.save
        flash.now.notice = "スポットを作成しました！"
        format.turbo_stream
        format.html { redirect_to root_path, notice: 'スポットを作成しました！' }
      else
        format.html { render partial: 'new_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: 'スポットを作成できませんでした' }
      end
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @spot.update(spot_params)
        flash.now.notice = "スポットを更新しました！"
        format.turbo_stream
        format.html { redirect_to root_path, notice: 'スポットを更新しました！' }
      else
        format.html { render partial: 'edit_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: 'スポットを更新できませんでした' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @spot.destroy
        format.html { redirect_to root_path, notice: 'スポットを削除しました', status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, alert: 'スポットを削除できませんでした' }
      end
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(
      :title, :accident_type, :contents,
      :accident_date, :longitude, :latitude, :user_id
    )
  end
end
