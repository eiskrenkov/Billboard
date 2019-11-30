module MediaHelper
  def file_tag(file)
    file_content = if file.video?
                     video_tag(url_for(file), controls: true, autoplay: true, loop: true)
                   else
                     image_tag(url_for(file))
                   end

    content_tag(:div, file_content, class: 'media-file')
  end
end
