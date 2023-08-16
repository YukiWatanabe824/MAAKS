class SpotsController < ApplicationController
  before_action :set_spot, only: %i[ show edit update destroy ]

  # GET /spots or /spots.json
  def index
    @spots = Spot.all
    render json: @spots
  end

  # GET /spots/1 or /spots/1.json
  def show
    render partial: "show"
  end

  # GET /spots/new
  def new
    @user = current_user
    @spot = Spot.new
    render partial: "new_form"
  end

  # GET /spots/1/edit
  def edit
    @user = current_user
    render partial: "edit_form"
  end

  # POST /spots or /spots.json
  def create
    @spot = Spot.new(spot_params)
    respond_to do |format|
      if @spot.save
        format.html { redirect_to root_path, notice: "Spot was successfully updated." }
      else
        Rails.logger.error @spot.errors.full_messages
        redirect_to root_path
      end
    end
  end

  # PATCH/PUT /spots/1 or /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to root_path, notice: "Spot was successfully updated." }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1 or /spots/1.json
  def destroy
    respond_to do |format|
      if @spot.destroy
        format.html { redirect_to root_path, notice: "Spot was successfully destroyed.", status: :see_other }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
