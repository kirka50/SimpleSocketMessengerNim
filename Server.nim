import std/sequtils
import std/net
type 
  Client = object
    socket: Socket
    address: string
var 
  clientsArray: seq[Client]


let socket = newSocket()
socket.bindAddr(Port(1234))
socket.listen()


while true:
  var client: Client
  socket.acceptAddr(client.socket, client.address)
  clientsArray.add(client)

  for i in clientsArray:
    i.socket.recvLine()
    echo (i)
