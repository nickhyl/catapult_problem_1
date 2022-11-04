require 'socket'

socket = TCPServer.new(4242)

loop do
  Thread.start(socket.accept) do |client|
    while request = client.gets
      command, *args = request.split(' ')
      case command
      when 'subscribe'
        client.puts('OK')
      when 'publish'
        client.puts('OK')
      end
    end
    client.close
  end
end

socket.close
