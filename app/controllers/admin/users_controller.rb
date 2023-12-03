# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController

  def index
    @user = current_user
    @pagy, @users = pagy(User.includes(avatar_attachment: :blob), items: 50)
  end
end
