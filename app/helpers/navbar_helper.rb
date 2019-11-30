module NavbarHelper
  def navbar_tag(&block)
    content_tag(:nav, class: 'nav navbar navbar-expand-lg fixed-top navbar-dark bg-dark') do
      content_tag(:div, capture(&block), class: 'container')
    end
  end

  def navbar_collapse_button
    bootstrap_icon_button(
      '', 'bars', class: 'navbar-toggler', data: { toggle: 'collapse', target: '#collapse-content' },
                  aria: { controls: 'collapse-content', expanded: false, label: 'toggle' }
    )
  end

  def navbar_collapse_section(&block)
    content_tag(:div, capture(&block), class: 'collapse navbar-collapse', id: 'collapse-content')
  end

  def navbar_brand
    link_to(application_name, root_path, class: 'navbar-brand')
  end

  def navbar_links_set(position: :auto, &block)
    content_tag(:ul, capture(&block), class: "navbar-nav mr-#{position}")
  end

  def navbar_link(title, url, options = {})
    section = options.delete(:section)

    default_options = {
      class: 'nav-link ' + (belongs_to_navigation_section?(section) ? 'active' : '')
    }

    content_tag(:li, link_to(title, url, default_options.merge!(options)), class: 'nav-item')
  end
end
