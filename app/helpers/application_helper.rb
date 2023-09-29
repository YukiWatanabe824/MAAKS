# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def turbo_stream_flash
    turbo_stream.update 'flash', partial: 'flash'
  end
end
