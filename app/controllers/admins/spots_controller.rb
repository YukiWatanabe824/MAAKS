# frozen_string_literal: true

class Admins::SpotsController < Admins::ApplicationController
  before_action :set_spot, only: %i[update destroy]

  def update
    @user = @spot.user
    respond_to do |format|
      if @spot.update(spot_params)
        flash.now.notice = t('controller.updated')
        format.turbo_stream
        format.html { redirect_to root_path, notice: t('controller.updated') }
      else
        format.html do
          render partial: 'spots/edit_form', locals: { spot: @spot, user: @user }, status: :unprocessable_entity, alert: t('controller.failed_to_updated')
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

  def spot_params
    params.require(:spot).permit(
      :title, :accident_type, :contents, :accident_date, :longitude, :latitude
    )
  end
end
