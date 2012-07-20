require './mini_redis'

r = MiniRedis.new

r.del 'list'

puts r.blpop('list', 1).inspect # => nil
