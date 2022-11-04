require 'socket'

connection = TCPSocket.open('localhost', 4242)

topic, *message = ARGV

connection.puts("publish #{topic} #{message.join(' ')}")
response = connection.gets

raise "Could not publish to topic #{topic}" unless response.chomp == 'OK'

p response
