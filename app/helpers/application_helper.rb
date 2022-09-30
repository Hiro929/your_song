module ApplicationHelper
  def default_meta_tags
    {
      site: 'your song',
      title: 'your song ~あなたに合った曲を~',
      reverse: true,
      separator: '|',
      description: 'あなたの感情に応じて曲を提案するアプリ',
      keyword: 'your song,音楽',
      cononical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('logo.ogp.png') },
        { href: image_url('logo.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'your song',
        title: 'your song ~あなたに合った曲を~',
        description: 'あなたの感情に応じて曲を提案するアプリ',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
      }
    }
  end
end
