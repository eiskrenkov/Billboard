module ButtonsHelper
  def bootstrap_button(title, options = {})
    size = options.delete(:size)
    type = options.delete(:type) || :link

    css_classes = %w[btn btn-primary]
    css_classes << "btn-#{size}" if size.present?

    default_options = {
      class: merge_css(css_classes, options.delete(:class))
    }

    if type == :link
      link_to(title, options.delete(:url), default_options.merge!(options))
    else
      default_options[:type] = type
      button_tag(title, default_options.merge!(options))
    end
  end

  def bootstrap_icon_button(title, icon, options = {})
    bootstrap_button(
      "#{fa_icon(icon)} #{title}".html_safe, options # rubocop:disable Rails/OutputSafety
    )
  end

  def new_button(options = {})
    default_options = {
      class: 'btn-success',
      url: new_resource_path
    }

    bootstrap_icon_button('New', 'plus', default_options.merge(options))
  end

  def edit_button(resource, options = {})
    default_options = {
      class: 'btn-info',
      size: :xs
    }
    options[:url] ||= edit_resource_path(resource) || ''

    bootstrap_icon_button('Edit', 'edit', default_options.merge(options))
  end

  def delete_button(resource, options = {})
    data_attributes = options.delete(:data) || {}
    default_options = {
      method: :delete,
      data: data_attributes.reverse_merge(confirm: t('confirmations.deletion')),
      class: 'btn-danger',
      size: :xs
    }

    options[:url] ||= resource_path(resource) || ''

    bootstrap_icon_button(t('shared.save'), 'trash', default_options.merge(options))
  end

  def save_button(options = {})
    default_options = {
      type: :submit,
      class: 'btn-primary'
    }

    bootstrap_icon_button(t('shared.save'), 'save', default_options.deep_merge(options))
  end

  def show_button(resource, options = {})
    default_options = {
      size: :xs
    }
    options[:url] ||= resource_path(resource) || ''

    bootstrap_icon_button(t('shared.show'), 'info', default_options.deep_merge(options))
  end

  def cancel_button(options = {})
    default_options = {
      class: 'btn-primary'
    }

    options[:url] ||= collection_path

    bootstrap_icon_button(t('shared.cancel'), 'ban', default_options.merge(options))
  end
end
