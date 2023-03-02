import std/sequtils
import std/net
type 
  Client = object
    socket: Socket
    address: string
var 
  clientsArray: seq[Client]
  connectedClientsThread: Thread[Socket]

let socket = newSocket()
socket.bindAddr(Port(1234))
socket.listen()


proc listenForMassage(clientSocket:Socket) {.thread.} = 
  while true:
    var msg = clientSocket.recvLine()
    echo(msg)

while true:
  var client: Client
  socket.acceptAddr(client.socket, client.address)
  clientsArray.add(client)
  createThread[Socket](connectedClientsThread,listenForMassage,(client.socket))
  