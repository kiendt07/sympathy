require "redis"

Recommendable.configure do |config|
  config.orm = :active_record
  uri = ENV["REDIS_URL"] ||"redis://localhost:6379/"
  config.redis = Redis.new(url: uri)
  config.redis_namespace = :recommendable
  config.auto_enqueue = true
  config.nearest_neighbors = nil
  config.furthest_neighbors = nil
  config.recommendations_to_store = 100
end
