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
    render partial: "drawer_newspot_form"
  end

  # GET /spots/1/edit
  def edit
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
        format.html { redirect_to spot_url(@spot), notice: "Spot was successfully updated." }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1 or /spots/1.json
  def destroy
    @spot.destroy

    respond_to do |format|
      format.html { redirect_to spots_url, notice: "Spot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    def spot_params
      params.permit(
        :title, :accident_type, :contents,
        :accident_date, :longitude, :latitude, :user_id
      )
    end
end
