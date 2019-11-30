class Devices::Synchronizer
  attr_reader :device

  def initialize(device)
    @device = device
  end

  def synchronize
    camellia_response = api_client.schedule(device.internal_name)
    return if camellia_response.blank?

    ActiveRecord::Base.transaction do
      device.media.delete_all

      camellia_response[:schedule]&.each do |media_data|
        create_media_instance(media_data)
      end
    end
  end

  private

  def create_media_instance(media_data)
    Media.new(media_data.slice(:name, :times_per_hour)).tap do |media|
      media.device = device
      attach_file_to(media, media_data[:file])
    end.save
  end

  def attach_file_to(media, file_data)
    file = downloader_for(file_data[:url]).download
    media.file.attach(io: file, filename: file_data[:name])
    media.content_type = file_data.fetch(:content_type)
  end

  def downloader_for(url)
    Media::Downloader.new(url)
  end

  def api_client
    @api_client ||= ApiClient::Camellia.instance
  end
end
