class Devices::ScheduleRequestPerformer
  attr_reader :device, :error

  def initialize(device)
    @device = device
  end

  def perform
    api_client.schedule(device.internal_name).tap do |camellia_response|
      validate_response(camellia_response)
      validate_incoming_media_size(camellia_response)
    end
  end

  private

  def validate_response(camellia_response)
    notice_error('Camellia did not respond properly') unless camellia_response.present? &&
                                                             camellia_response.key?(:schedule)
  end

  def validate_incoming_media_size(camellia_response)
    return if incoming_media_size(camellia_response) <= device.bytes_capacity

    notice_error('Device has not enough space to store incoming media')
  end

  def incoming_media_size(camellia_response)
    camellia_response.fetch(:schedule).inject(0) do |sum, media|
      sum + media.dig(:file, :size)
    end
  end

  def success?
    error.blank?
  end

  def notice_error(message)
    @error = message
  end

  def api_client
    @api_client ||= ApiClient::Camellia.instance
  end
end
