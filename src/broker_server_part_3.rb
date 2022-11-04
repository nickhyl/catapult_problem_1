require 'socket'

socket = TCPServer.new(4242)

topic_queue = Queue.new
Thread.start({}) do |topics|
  while event = topic_queue.pop
    command, *args = event
    case command
    when 'publish'
      topic, *message = args
      topics[topic].each do |client_queue|
        client_queue.push(message.join(' '))
      end
    when 'subscribe'
      topic, client_queue = args
      topics[topic] = [] if topics[topic].nil?
      topics[topic] << client_queue
    end
  end
end

loop do
  Thread.start(socket.accept, Queue.new) do |client, queue|
    while request = client.gets
      event = request.split(' ')
      case event[0]
      when 'subscribe'
        topic_queue << (event + [queue])
        client.puts('OK')
        loop do
          message = queue.pop
          client.puts(message)         
        end
      when 'publish'
        topic_queue << event
        client.puts('OK')
      end
    end
    client.close
  end
end

socket.close
