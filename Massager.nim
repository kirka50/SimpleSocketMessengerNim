import std/net
import  client


var
    userName: string
    mySocket,myConnectedSocket: Socket


proc tryConnect(): Socket = 
    mySocket = client.createNewSocket()
    myConnectedSocket = client.createConnetion(mySocket,"127.0.0.1",1234)
    return myConnectedSocket    


proc askUserName(): string =
    echo("Enter your name")
    userName = readLine(stdin)
    return userName


proc readAndSendMassage(myConnectedSocket: Socket; userName: string) = 
    var massage = readLine(stdin)
    echo("trying to send: " & massage)
    myConnectedSocket.sendMassage(userName & ": " & massage & "\n")


proc massagerRuntime(myConnectedSocket: Socket; userName: string) =
    var 
        reciever: Socket
        recieverAdress: string
    while true:        
        readAndSendMassage(myConnectedSocket, userName)

proc start() = 
    userName = askUserName()
    echo("Your name is: ", userName)
    echo("We will try to connect with server")
    myConnectedSocket = tryConnect()
    massagerRuntime(myConnectedSocket, userName)




start()

