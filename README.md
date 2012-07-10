miniredis-ruby
==============

A redis client in ruby. Really lightweight! Only 28 lines! :)
Usage: 

```ruby
   r = MiniRedis.new
   r.set 'foo', 2 # => "OK"
   r.get 'foo' # => "2"
 
   r.sadd 'boo', '1', '2', '3' # => 0
   r.smembers 'boo' # => ["1", "2", "3"]
```