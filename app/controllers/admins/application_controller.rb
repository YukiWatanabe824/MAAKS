# frozen_string_literal: true

class Admins::ApplicationController < ApplicationController
  before_action :raise_permission_error

  def raise_permission_error
    raise(ActionController::RoutingError, 'Not Found') if !current_user.admin?
  end
end
