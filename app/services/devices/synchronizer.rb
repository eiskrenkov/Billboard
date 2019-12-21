class Devices::Synchronizer
  attr_reader :device, :error

  def initialize(device)
    @device = device
  end

  def synchronize
    camellia_response = api_client.schedule(device.internal_name)
    return unless validate_response(camellia_response)

    ActiveRecord::Base.transaction do
      device.media.delete_all

      camellia_response[:schedule]&.each do |media_data|
        create_media_instance(media_data)
      end
    end
  end

  private

  def validate_response(camellia_response)
    return notice_error('Camellia did not respond properly') unless camellia_response.present? &&
                                                                    camellia_response.key?(:schedule)

    total_media_size = camellia_response.fetch(:schedule).inject(0) { |sum, media| sum + media.dig(:file, :size) }
    if total_media_size > device.bytes_capacity
      return notice_error('Device has no enough space to store incoming media')
    end

    true
  end

  def notice_error(message)
    @error = message
    false
  end

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
