class ApiClient::Camellia < ApiClient::Base
  def schedule(device_internal_name)
    handle_errrors do
      get('api/devices/schedule', device_internal_name: device_internal_name)
    end
  end

  private

  def handle_errrors
    yield
  rescue ApiClient::Base::Error
    nil
  end

  def api_host
    Settings.instance.service_url
  end
end
