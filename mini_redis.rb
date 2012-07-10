# A lightweight redis client in ruby
# 
# Usage: 
#   r = MiniRedis.new
#   r.set 'foo', 2 # => "OK"
#   r.get 'foo' # => "2"
# 
#   r.sadd 'boo', '1', '2', '3' # => 0
#   r.smembers 'boo' # => ["1", "2", "3"]

require 'socket'

class MiniRedis
  def initialize host = 'localhost', port = 6379
    @socket = TCPSocket.new host, port
  end
  
  def method_missing *args
    @socket.print "*#{args.length}\r\n"
    args.each {|s| @socket.print "$#{s.to_s.length}\r\n#{s}\r\n"}
    
    reply = @socket.gets
    type, body = reply[0], reply[1..-3]
    case type
    when '+' then body
    when '-' then raise StandardError.new(body)
    when ':' then body.to_i
    when '$' then read_bulk(body.to_i)
    when '*' then body.to_i.times.map {read_bulk(@socket.gets[1..-3].to_i)}
    else 'unknown return value'
    end
  end
  
  private
  def read_bulk n
    @socket.gets[0..n-1] unless n == -1
  end
end

