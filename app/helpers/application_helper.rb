# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def turbo_stream_flash
    turbo_stream.update 'flash', partial: 'flash'
  end

  def format_content(text)
    simple_format(html_escape(text))
  end

  def page_title(page_title = '')
    base_title = 'MAAKS'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def default_meta_tags
    {
      reverse: false,
      description: '安全にサイクリングをして、無事に帰ってくる。MAAKSはそんな思いから生まれたサービスです。みんなでサイクリング中のヒヤッとした経験や事故に遭った経験をマッピングして共有することで、あぶないスポットを事前に把握。集合知で事故を未然に防ぎます。',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og:,
      twitter: {
        card: 'summary_large_image',
        site: '@maaks790590'
      }
    }
  end

  private

  def og
    {
      site_name: 'MAAKSマークス 安全にサイクリングするためのWEBサービス',
      description: '安全にサイクリングをして、無事に帰ってくる。MAAKSはそんな思いから生まれたサービスです。みんなでサイクリング中のヒヤッとした経験や事故に遭った経験をマッピングして共有することで、あぶないスポットを事前に把握。集合知で事故を未然に防ぎます。',
      type: 'website',
      url: request.original_url,
      image: image_url('ogp.jpg'),
      locale: 'ja_JP'
    }
  end
end
