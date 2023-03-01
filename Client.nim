import std/net


proc createNewSocket*(): Socket = 
    let socketName = newSocket()
    echo("Socket Created")
    return socketName


proc sendMassage*(connectedSocket: Socket; massage: string) = 
    connectedSocket.send(massage)


proc closeSocket(socket: Socket) = 
    socket.close()
    echo("Socket was closed")
    

proc createConnetion*(socket: Socket; adreas: string; port: int): Socket =
    try:
        socket.connect(adreas,Port(port))
        echo("Socket Connected")
        return socket
    except OSError as e:
        echo(e.msg)
        echo("Not connected and will close")
        closeSocket(socket)
        