module ApplicationHelper
  def application_name
    "#{Rails.application.class.parent_name} #{Rails.env.capitalize}"
  end

  def merge_css(*css)
    class_list = css.each_with_object([]) do |part, memo|
      case part
      when String
        memo << part.split
      when Array
        memo << part
      end
    end

    class_list.uniq.join(' ')
  end

  def default_resource_update_path
    resource.new_record? ? collection_path : resource_path
  end

  def show_raw_details_for(data)
    content_tag(:pre, JSON.pretty_generate(data))
  end

  def debug_mode?
    Rails.env.development? && Settings.instance.debug
  end
end
