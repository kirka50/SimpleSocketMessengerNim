import std/net
import  Client
var
    userName: string
    mySocket,myConnectedSocket: Socket

proc tryConnect(): Socket = 
    try:
        mySocket = Client.createNewSocket()
    except:
        echo("SocketCannotBeCreated")
    try:
        myConnectedSocket = Client.createConnetion(mySocket,"127.0.0.1",1234)
    except: 
        echo("Socket Created But not connected and will be closed")
    return myConnectedSocket    

proc askUserName(): string =
    echo("Enter your name")
    userName = readLine(stdin)
    return userName

proc start() = 
    userName = askUserName()
    echo("Your name is: ", userName)
    discard

