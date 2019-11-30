class ApiClient::Base
  include Singleton

  class Error < StandardError; end

  def get(endpoint, params = {})
    perform_request(:get, endpoint, params)
  end

  def post(endpoint, params = {})
    perform_request(:post, endpoint, params)
  end

  private

  def perform_request(verb, endpoint, params)
    JSON.parse(
      connection.send(verb, endpoint, params).body
    ).with_indifferent_access
  rescue StandardError => e
    raise Error, e.message
  end

  def api_host
    raise NotImplementedError
  end

  def connection
    @connection ||= Faraday.new(api_host)
  end
end
