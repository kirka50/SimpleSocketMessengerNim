import std/tasks
import std/[net]
import  client


var
    userName: string
    mySocket, myConnectedSocket: Socket
    connectedClientsThread: Thread[Socket]


proc tryConnect(): Socket = 
    mySocket = client.createNewSocket()
    myConnectedSocket =  client.createConnetion(mySocket,"127.0.0.1",1234)
    return myConnectedSocket    


proc askUserName(): string =
    echo("Enter your name")
    userName = readLine(stdin)
    echo("Your name is: ", userName)
    return userName


proc sendMassage(myConnectedSocket: Socket; userName: string) {.thread.}  = 
    var massage = readLine(stdin)
    massage = userName & ": " & massage & "\n"
    client.sendMassage(myConnectedSocket, massage)


proc acceptMassages(myConnectedSocket: Socket)  = 
    while true:   
        var msg = myConnectedSocket.recvLine()
        echo(msg)
    

proc massagerRuntime(myConnectedSocket: Socket; userName: string)  =
    createThread[Socket](connectedClientsThread,acceptMassages,(myConnectedSocket))
    while true:
        sendMassage(myConnectedSocket,userName)


proc start() = 
    userName = askUserName()
    echo("We will try to connect with server")
    myConnectedSocket = tryConnect()
    massagerRuntime(myConnectedSocket, userName)





start()


