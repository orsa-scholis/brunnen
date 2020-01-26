# frozen_string_literal: true

module NavbarHelper
  def navbar_item(title, path, **options)
    content_tag('li', class: navbar_item_class(path)) do
      link_to title, path, { class: 'nav-link' }.merge(options)
    end
  end

  private

  def navbar_item_class(path)
    return 'nav-item active' if current_page?(path)

    'nav-item'
  end
end
