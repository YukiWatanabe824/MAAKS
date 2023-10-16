# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def turbo_stream_flash
    turbo_stream.update 'flash', partial: 'flash'
  end

  def format_content(text)
    simple_format(html_escape(text))
  end
end
