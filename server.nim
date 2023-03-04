import std/sequtils
import std/[net, locks]
# Thread-like server. Only adress by adress compare work corretly, dont know why but socket by socket cant work normaly
type 
  
  Client = object
    socket: Socket
    address: string
var 
  clientsArray: seq[Client]
  clientsArrayPtr = addr(clientsArray)
  connectedClientsThread: Thread[Client]
  lock: Lock

let socket = newSocket()
socket.bindAddr(Port(1234))
socket.listen()


proc sendMassageToOthers(client: Client; massage: string) = 
  acquire(lock)
  let clientsArray = cast[ptr seq[Client]](clientsArrayPtr)[]
  for i in clientsArray:
    if i.address != client.address: #Adress by adress compare
      i.socket.send(massage & "\n")
  release(lock)


proc listenForMassage(client: Client) {.thread.} = 
  while true:
    var msg = client.socket.recvLine()
    sendMassageToOthers(client,msg)



initLock(lock)
while true:
  var client: Client
  socket.acceptAddr(client.socket, client.address)
  echo("connected "& client.address)
  clientsArray.add(client)
  createThread[Client](connectedClientsThread,listenForMassage,(client))
  