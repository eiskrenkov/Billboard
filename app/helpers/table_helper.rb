module TableHelper
  def table_tag(options = {}, &block)
    options[:class] = merge_css(options[:class], %w[table table-hover])
    content_tag(:table, capture(&block), options)
  end
end
