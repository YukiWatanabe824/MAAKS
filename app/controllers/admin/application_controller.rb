# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  before_action :raise_permission_error

  def raise_permission_error
    raise ActionController::RoutingError.new('Not Found') if !current_user.admin?
  end
end
