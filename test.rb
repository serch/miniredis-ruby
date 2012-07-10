require './mini_redis'

r = MiniRedis.new

r.del 'list'
r.rpush 'list', 'a', 'b', 'c', 'd'

r.multi
r.lrange 'list', 0, 2
r.lrange 'list', 2, 3
r.exec # => [["a", "b", "c"], ["c", "d"]]
