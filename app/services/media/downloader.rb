require 'open-uri'

class Media::Downloader
  include ActiveModel::Validations

  class RemoteFile < DelegateClass(Tempfile)
    attr_accessor :original_filename
  end

  attr_reader :media_url

  validates :media_url, presence: true
  validate :media_url_correctness

  def initialize(media_path)
    @media_url = URI(media_path.to_s)
  end

  def download
    return unless valid?

    RemoteFile.new(Kernel.open(media_url)).tap do |file|
      file.original_filename = File.basename(media_url.path)
    end
  rescue StandardError => e
    errors.add(:base, "failed to download: #{e.message}")
    nil
  end

  private

  def media_url_correctness
    errors.add(:media_url, 'url is not valid') unless media_url.is_a?(URI::HTTPS)
  end
end
