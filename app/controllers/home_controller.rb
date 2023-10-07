# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_mapbox, only: %i[index]

  # GET /users or /users.json
  def index
    @user = User.includes(:spot).find(current_user.id) if current_user
    @spots_pagy, @spots = pagy(Spot.order(created_at: :desc))
    @my_spots_pagy, @my_spots = pagy(Spot.order(created_at: :desc).where("user_id = #{current_user.id}")) if user_signed_in?

    if session[:logged_out]
      @signed_out = true
      session.delete(:logged_out)
    end

    return unless session[:first_access].nil?

    @first_access = true
    session[:first_access] = true
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {})
  end

  def set_mapbox
    @mapbox_access_token = Rails.application.credentials.mapbox.access_token
    @mapbox_style = Rails.application.credentials.mapbox.style
  end
end
