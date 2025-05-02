import net


when isMainModule:
  while true:
    let client = newSocket()
    client.connect("127.0.0.1",Port(8080))
    client.send(stdin.readLine & "\n")
    echo  client.recv(1024)
    client.close()
