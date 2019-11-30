class ApiClient::Camellia < ApiClient::Base
  def schedule(device_internal_name)
    get('api/devices/schedule', device_internal_name: device_internal_name)
  end

  private

  def api_host
    Settings.instance.service_url
  end
end
