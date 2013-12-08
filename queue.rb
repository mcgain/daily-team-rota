require 'redis'

class Queue
  @redis = nil
  def self.redis
    uri = URI.parse(ENV["REDISTOGO_URL"])
    @redis ||= Redis.new( host: uri.host, port: uri.port, password: uri.password)
  end

  def self.next
    recipient = redis.lpop('current')
    recipient || reshuffle
  end

  def self.reshuffle
    people = redis.lrange('people', 0, -1).shuffle
    recipient = people.shift
    redis.lpush 'current', people
    recipient
  end
end
