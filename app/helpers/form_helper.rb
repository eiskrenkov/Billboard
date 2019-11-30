module FormHelper
  def form_bootstrap_card(title, &block)
    card_header = [
      title.capitalize,
      resource.class.name.demodulize,
      resource.id.presence
    ].join(' ')

    content_tag(:div, class: 'card') do
      content_tag(:div, class: 'card-body') do
        safe_join([content_tag(:h2, card_header), content_tag(:hr), capture(&block)])
      end
    end
  end
end
