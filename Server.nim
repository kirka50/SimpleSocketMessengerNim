import std/net
let socket = newSocket()
socket.bindAddr(Port(1235))
socket.listen()

var client: Socket
var address = ""
while true:
  socket.acceptAddr(client, address)
  socket.listen()
  echo "Client connected from: ", address