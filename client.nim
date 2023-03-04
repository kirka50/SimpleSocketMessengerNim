import std/[net]



proc createNewSocket*(): Socket = 
    let socket = newSocket()
    echo("Socket Created")
    return socket


proc sendMassage*(connectedSocket: Socket; massage: string) = 
    connectedSocket.send(massage)



proc closeSocket(socket: Socket) = 
    socket.close()
    echo("Socket was closed")
    
    

proc setListenToSocket*(socket: Socket) = 
    socket.listen()
    

proc createConnetion*(socket: Socket; adreas: string; port: int): Socket =
    try:
        socket.connect(adreas,Port(port))
        echo("Socket Connected")
        return socket
    except OSError as e:
        echo(e.msg)
        echo("Not connected and will close")
        closeSocket(socket)
        