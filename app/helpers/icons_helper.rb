module IconsHelper
  def fa_icon(names = 'flag', original_options = {})
    options = original_options.deep_dup

    classes = ['fa']
    classes.concat IconsBuilder.icon_names(names)
    classes.concat Array(options.delete(:class))

    text = options.delete(:text)
    right_icon = options.delete(:right)

    IconsBuilder.icon_join(
      content_tag(:i, nil, options.merge(class: classes)), text, right_icon
    )
  end

  module IconsBuilder
    extend ActionView::Helpers::OutputSafetyHelper

    class << self
      def icon_join(icon, text, reverse_order = false)
        return icon if text.blank?

        elements = [icon, ERB::Util.html_escape(text)]
        elements.reverse! if reverse_order
        safe_join(elements, ' ')
      end

      def icon_names(names = [])
        array_value(names).map { |n| "fa-#{n}" }
      end

      def array_value(value = [])
        value.is_a?(Array) ? value : value.to_s.split(/\s+/)
      end
    end
  end
end
