require 'redis'

def redis
  @redis ||= ConfigLoader.load(:redis) { |redis_config| Redis.new(redis_config) }
end
