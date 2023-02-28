import std/net


proc createNewSocket*(): Socket = 
    let socketName = newSocket()
    echo("Socket Created")
    return socketName
    

proc createConnetion*(socket: Socket; adreas: string; port: int): Socket =
    socket.connect(adreas,Port(port))
    echo("Socket Connected")
    return socket

