require 'socket'

connection = TCPSocket.open('localhost', 4242)

topic = ARGV[0]
connection.puts("subscribe #{topic}")
response = connection.gets
print response

raise "Could not subscribe to topic #{topic} #{response}" unless response.chomp == 'OK'

while message = connection.gets
  p message
end
