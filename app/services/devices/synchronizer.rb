class Devices::Synchronizer
  attr_reader :device, :camellia_response

  def initialize(device, camellia_response)
    @device = device
    @camellia_response = camellia_response
  end

  def synchronize
    return if camellia_response.blank?

    ActiveRecord::Base.transaction do
      device.media.delete_all

      camellia_response[:schedule]&.each do |media_data|
        DownloadMediaJob.perform_later(device, media_data)
      end
    end
  end
end
