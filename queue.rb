require 'redis'

class Queue
  @redis = nil
  def self.redis
    if ENV["REDISTOGO_URL"]
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis ||= Redis.new( host: uri.host, port: uri.port, password: uri.password)
    else
      @redis ||= Redis.new
    end
  end

  def self.next
    recipient = redis.lpop('current')
    recipient || reshuffle
  end

  def self.reshuffle
    people = self.people.shuffle
    recipient = people.shift
    redis.lpush 'current', people
    recipient
  end

  def self.people
    redis.lrange('people', 0, -1)
  end

  def self.current
    redis.lrange('current', 0, -1)
  end

  def self.add_person(email)
    redis.rpush 'people', email
  end

  def self.remove_person(email)
    redis.lrem 'current', 1, email
    redis.lrem 'people', 1, email
  end
end
