import std/[asyncnet, asyncdispatch]

var clients {.threadvar.}: seq[AsyncSocket]

proc processClient(client: AsyncSocket) {.async.} =
  while true:
    let line = await client.recvLine()
    echo(line)
    if line.len == 0: break
    for c in clients:
        if c != client:
            await c.send(line & "\c\L")

proc serve() {.async.} =
  clients = @[]
  var server = newAsyncSocket()
  server.setSockOpt(OptReuseAddr, true)
  server.bindAddr(Port(12345))
  server.listen()
  
  while true:
    let client = await server.accept()
    clients.add client
    
    asyncCheck processClient(client)

asyncCheck serve()
runForever()