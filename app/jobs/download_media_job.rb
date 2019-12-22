class DownloadMediaJob < ApplicationJob
  queue_as :media

  def perform(device, media_data)
    Media.new(media_data.slice(:name, :times_per_hour)).tap do |media|
      media.device = device
      attach_file_to(media, media_data[:file])
    end.save
  end

  private

  def attach_file_to(media, file_data)
    file = downloader_for(file_data[:url]).download
    media.file.attach(io: file, filename: file_data[:name])
    media.content_type = file_data.fetch(:content_type)
  end

  def downloader_for(url)
    Media::Downloader.new(url)
  end
end
