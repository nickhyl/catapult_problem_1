require 'socket'

socket = TCPServer.new(4242)

topics = {}

loop do
  Thread.start(socket.accept) do |client|
    while request = client.gets
      command, *args = request.split(' ')
      case command
      when 'subscribe'
        topic = args[0]
        topics[topic] = [] if topics[topic].nil?
        topics[topic] << client
        client.puts('OK')
      when 'publish'
        topic = args[0]
        message = args.drop(1).join(' ')
        topics[topic].each { |sub_client| sub_client.puts(message) } unless topics[topic].nil?
        client.puts('OK')
      end
    end
    client.close
  end
end

socket.close
