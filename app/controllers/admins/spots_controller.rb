# frozen_string_literal: true

class Admins::SpotsController < Admins::ApplicationController
  before_action :set_spot, only: %i[update destroy]

  def update
    @user = @spot.user
    respond_to do |format|
      if @spot.update(spot_params)
        format.turbo_stream { flash.now[:notice] = t('controller.updated') }
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
        set_paging
        check_signed_out_session
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
      :title, :accident_type, :contents, :accident_date, :longitude, :latitude
    )
  end
end
