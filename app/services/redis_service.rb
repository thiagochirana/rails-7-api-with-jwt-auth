require "redis"

class RedisService
  REDIS ||= Redis.new(url: ENV['REDIS_URL'])
  def self.put(key, value, expires_at: nil)
    if expires_at
      ttl = expires_at * 60
      REDIS.set(key, value, ex: ttl)
    else
      REDIS.set(key, value)
    end
  end

  def self.get(key)
    REDIS.get(key)
  end

  def self.secs_to_expire key
    REDIS.ttl(key)
  end
end
